App.Order = DS.Model.extend({
  token: DS.attr('string'),
  number: DS.attr('string'),

  additionalTaxTotal: DS.attr('string'),
  adjustmentTotal: DS.attr('string'),
  channel: DS.attr('string'),
  completedAt: DS.attr('string'),
  createdAt: DS.attr('string'),
  currency: DS.attr('string'),
  displayAdditionalTaxTotal: DS.attr('string'),
  displayIncludedTaxTotal: DS.attr('string'),
  displayItemTotal: DS.attr('string'),
  displayShipTotal: DS.attr('string'),
  displayTaxTotal: DS.attr('string'),
  displayTotal: DS.attr('string'),
  email: DS.attr('string'),
  includedTaxTotal: DS.attr('string'),
  itemTotal: DS.attr('string'),
  lineItems: DS.hasMany('line-item'),
  paymentState: DS.attr('string'),
  paymentTotal: DS.attr('string'),
  shipTotal: DS.attr('string'),
  shipmentState: DS.attr('string'),
  specialInstructions: DS.attr('string'),
  state: DS.attr('string', {defaultValue: 'cart'}),
  taxTotal: DS.attr('string'),
  total: DS.attr('string'),
  totalQuantity: Em.computed.alias('lineItems.length'),
  updatedAt: DS.attr('string'),

  shipAddress: DS.belongsTo('ship-address'),
  billAddress: DS.belongsTo('bill-address'),

  shipments: DS.hasMany('shipment'),
  payments: DS.hasMany('payment'),
  paymentId: Em.computed('payments.[]', function() {
    return this.get('payments.firstObject.id');
  }),
  orderHasPayment: Em.computed.notEmpty('payments'),

  permissions: DS.attr('object'),
  // permissions: {can_update:false}
  // userId: null
  // adjustments: []
  // checkoutSteps: DS.attr('array'),
  paymentMethods: DS.hasMany('paymentMethod'),

  useShippingAddress: DS.attr('boolean', {defaultValue: false}),

  // #order info

  isEmpty: Em.computed.empty('lineItems'),
  isComplete: Em.computed('checkoutStep', function() {
    return this.get('checkoutStep') > 3;
  }),

  checkoutStates: [
    'cart',
    'address',
    'delivery',
    'payment',
    'confirm',
    'complete',
    'resumed'
  ],

  checkoutSteps: {
    cart: 0,
    address: 1,
    delivery: 2,
    payment: 3,
    confirm: 4,
    complete: 5,
    resumed: 6
  },

  checkoutStep: Em.computed('state', function() {
    return this.get('checkoutSteps')[this.get('state')];
  }),

  advanceState(targetState) {
    let targetStep = this.get('checkoutSteps')[targetState];
    let currentStep = this.get('checkoutStep');
    return new Em.RSVP.Promise((resolve, reject) => {
      if (targetStep === currentStep + 1) {
        return $.ajax(`api/checkouts/${this.get('number')}/next`, {
          type: "PUT",
          dataType: "json",
          data: {
            order_token: this.get('token')
          },
          success(data) {
            this.store.pushPayload('order',
              {order: data});
            return resolve(data);
          },
          error(error, type, name) {
            alert(error.responseText);
            return reject(error, type, name);
          }
        });
      } else if (targetStep > currentStep + 1) {
        return reject();
      } else {
        return resolve(this);
      }
    });
  },

  createLineItem(item) {
    let self = this;
    return new Em.RSVP.Promise((resolve, reject) => {
      $.ajax(`api/orders/${self.get('number')}/line_items`, {
        type: "POST",
        datatype: 'json',
        data: {
          order_token: self.get('token'),
          line_item: {
            variant_id: item.get('variantId'),
            custom_item_hash: item.get('customItemHash'),
            order_notes: item.get('orderNotes')
          }
        },
        success(data) {
          if (item.isCustomItem) {
            data.customItem = item;
          }
          const store = self.get('store');
          store.pushPayload('line-item', {line_item: data});
          self.addLineItem(data.id);
          return resolve(self, data);
        },
        error(xhr) {
          return reject(xhr);
        }
      });
    });
  },

  addLineItem(lineItemId) {
    let lineItem = this.store.peekRecord('line-item', lineItemId);
    return this.get('lineItems').addObject(lineItem);
  },

  removeLineItem(lineItem) {
    let self = this;
    let customItem = lineItem.get('customItem');
    return new Em.RSVP.Promise((resolve, reject) => {
      $.ajax(`api/orders/${self.get('number')}/line_items/${lineItem.get('id')}`, {
        type: 'DELETE',
        datatype: 'json',
        data: {
          order_token: self.get('token')
        },
        success() {
          if (lineItem.get('variant')) {
            lineItem.get('variant').incrementProperty('totalInCart', -lineItem.get('quantity'));
          }
          self.get('lineItems').removeObject(lineItem);
          if (customItem.content !== null) {
            customItem.set('state', 'precart');
            customItem.set('lineItem', null);
            customItem.content.save();
          }
          return resolve(self);
        },
        error(xhr) {
          if (xhr.status === 404) {
            self.get('lineItems').removeRecord(lineItem);
            return resolve(self);
          } else {
            return reject(xhr);
          }
        }
      });
    });
  },

  updateAddresses(alertOnFailure) {
    let self = this;
    return new Em.RSVP.Promise((resolve, reject) => {
      $.ajax(`api/checkouts/${self.get('number')}`, {
        type: "PUT",
        datatype: 'json',
        data: {
          order_token: self.get('token'),
          order: self.serializeAddresses()
        },
        success(payload) {
          self.store.pushPayload('order',
            {order: payload});
          return resolve(payload, self);
        },
        error(xhr, error, status) {
          if (alertOnFailure) {
            let message = [`${xhr.responseJSON.error}\n`];
            $.each(xhr.responseJSON.errors, function(field, errs) {
              let title = field.split('.')[1];
              let errors = errs.join(', ');
              return message.push(`${title}: ${errors}\n`);
            });
            alert(message.join('\n'));
          }
          return reject();
        }
      });
    });
  },

  serializeAddresses() {
    let payload;
    if (this.get('useShippingAddress')) {
      payload = {
        ship_address_attributes: this.get('shipAddress').getAttributes(),
        bill_address_attributes: this.get('shipAddress').getAttributes()
      };
    } else {
      payload = {
        ship_address_attributes: this.get('shipAddress').getAttributes(),
        bill_address_attributes: this.get('billAddress').getAttributes()
      };
    }
    return payload;
  },

  updateShipments(alertOnFailure) {
    let self = this;
    return new Em.RSVP.Promise((resolve, reject) => {
      $.ajax(`api/checkouts/${self.get('number')}`, {
        type: "PUT",
        datatype: 'json',
        data: {
          order_token: self.get('token'),
          order: {
            shipments_attributes: self.serializeShipments()
          }
        },
        success(payload) {
          self.store.pushPayload('order',
            {order: payload});
          return resolve(payload, self);
        },
        error(xhr, error, status) {
          if (alertOnFailure) {
            let message = [`${xhr.responseJSON.error}\n`];
            $.each(xhr.responseJSON.errors, function(field, errs) {
              let title = field.split('.')[1];
              let errors = errs.join(', ');
              return message.push(`${title}: ${errors}\n`);
            });
            alert(message.join('\n'));
          }
          return reject();
        }
      });
    });
  },

  serializeShipments() {
    let payload = {};
    $.each(this.get('shipments.currentState'), (index, shipment) => {
      payload[`${index}`] = {
        selected_shipping_rate_id: shipment.get('selectedShippingId'),
        id: shipment.get('id')
      };
    });
    return payload;
  },

  getPaymentAttributes() {
    let self = this;
    return new Em.RSVP.Promise((resolve, reject) => {
      $.ajax(`api/orders/${self.get('number')}/payments/new`, {
        type: "GET",
        datatype: 'json',
        data: {
          order_token: self.get('token')
        },
        success(payload) {
          return resolve(payload);
        },
        error(xhr) {
          alert(xhr.responseJSON.errors.base.join('\n'));
          return reject(xhr);
        }
      });
    });
  },

  createPayment(paymentMethod, card) {
    let self = this;
    let paymentMethodId = paymentMethod.get('id');
    return new Em.RSVP.Promise(function(resolve, reject) {
      if (self.get('state') === 'complete') { return resolve(); }
      let paymentSource = {};
      paymentSource[paymentMethodId] =
        {gateway_payment_profile_id: card.get('token')};
      return $.ajax(`api/checkouts/${self.get('number')}`, {
        type: "PUT",
        dataType: 'json',
        contentType: 'application/json',
        data: JSON.stringify({
          order_token: self.get('token'),
          order: {
            payments_attributes: [
              {payment_method_id: paymentMethodId}
            ]
          },
          payment_source: paymentSource
        }),
        success(payload) {
          $.each(payload.payments, (index, payment) => {
            payment.orderId = self.get('id');
          });
          self.store.pushPayload('order',
            {order: payload});
          return resolve(payload);
        },
        error(xhr) {
          alert(xhr.responseJSON.errors.base.join('\n'));
          card.clearData();
          return reject(xhr);
        }
      });
    });
  },

  completePayment() {
    let self = this;
    return new Em.RSVP.Promise(function(resolve, reject) {
      if (self.get('state') === !'complete') { return resolve(); }
      return $.ajax(`api/checkouts/${self.get('number')}`, {
        type: 'PUT',
        dataType: 'json',
        contentType: 'application/json',
        data: JSON.stringify(
          {order_token: self.get('token')}),
        success(payload) {
          self.store.pushPayload('order',
            {order: payload});
          return resolve(payload);
        },
        error(xhr) {
          alert(xhr.responseJSON.errors.base.join('\n'));
          return reject(xhr);
        }
      });
    });
  }
});

