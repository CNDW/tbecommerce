App.Order = DS.Model.extend
  token: DS.attr 'string'
  number: DS.attr 'string'

  additionalTaxTotal: DS.attr 'string'
  adjustmentTotal: DS.attr 'string'
  channel: DS.attr 'string'
  completedAt: DS.attr 'string'
  createdAt: DS.attr 'string'
  currency: DS.attr 'string'
  displayAdditionalTaxTotal: DS.attr 'string'
  displayIncludedTaxTotal: DS.attr 'string'
  displayItemTotal: DS.attr 'string'
  displayShipTotal: DS.attr 'string'
  displayTaxTotal: DS.attr 'string'
  displayTotal: DS.attr 'string'
  email: DS.attr 'string'
  includedTaxTotal: DS.attr 'string'
  itemTotal: DS.attr 'string'
  lineItems: DS.hasMany 'lineItem'
  paymentState: DS.attr 'string'
  paymentTotal: DS.attr 'string'
  shipTotal: DS.attr 'string'
  shipmentState: DS.attr 'string'
  specialInstructions: DS.attr 'string'
  state: DS.attr 'string', defaultValue: 'cart'
  taxTotal: DS.attr 'string'
  total: DS.attr 'string'
  totalQuantity: Em.computed.alias 'lineItems.length'
  updatedAt: DS.attr 'string'

  shipAddress: DS.belongsTo 'shipAddress'
  billAddress: DS.belongsTo 'billAddress'

  shipments: DS.hasMany 'shipment'
  payments: DS.hasMany 'payment'
  paymentId: Em.computed 'payments.[]', ->
    @get('payments.firstObject.id')
  orderHasPayment: Em.computed.notEmpty('payments')

  permissions: DS.attr 'object'
  # permissions: {can_update:false}
  # userId: null
  # adjustments: []
  checkoutSteps: DS.attr 'array'
  paymentMethods: DS.hasMany 'paymentMethod'

  useShippingAddress: DS.attr 'boolean', defaultValue: no

  # #order info

  isEmpty: Em.computed.empty 'lineItems'
  isComplete: Em.computed 'checkoutStep', ->
    @get('checkoutStep') > 3

  checkoutStates: [
    'cart'
    'address'
    'delivery'
    'payment'
    'confirm'
    'complete'
    'resumed'
  ]
  checkoutSteps:
    cart: 0
    address: 1
    delivery: 2
    payment: 3
    confirm: 4
    complete: 5
    resumed: 6

  checkoutStep: Em.computed 'state', ->
    @get('checkoutSteps')[@get('state')]

  advanceState: (targetState)->
    targetStep = @get('checkoutSteps')[targetState]
    currentStep = @get('checkoutStep')
    self = this
    return new Em.RSVP.Promise (resolve, reject)->
      if targetStep == currentStep + 1
        $.ajax "api/checkouts/#{self.get('number')}/next",
          type: "PUT"
          dataType: "json"
          data:
            order_token: self.get('token')
          success: (data)->
            self.store.pushPayload 'order',
              order: data
            resolve(data)
          error: (error, type, name)->
            alert(error.responseText)
            reject(error, type, name)
      else if targetStep > currentStep + 1
        reject()
      else
        resolve(self)

  createLineItem: (item)->
    self = this
    return new Em.RSVP.Promise (resolve, reject)->
      $.ajax "api/orders/#{self.get('number')}/line_items",
        type: "POST"
        datatype: 'json'
        data:
          order_token: self.get('token')
          line_item:
            variant_id: item.get('variantId')
            options:
              custom_item_hash: item.get('customItemHash')
              order_notes: item.get('orderNotes')
        success: (data)->
          if item.isCustomItem
            data.customItem = item
          self.store.pushPayload 'lineItem',
            line_item: data
          self.addLineItem data.id
          resolve(self, data)
        error: (xhr)->
          reject(xhr)

  addLineItem: (lineItemId)->
    lineItem = @store.findRecord 'lineItem', lineItemId
    @get('lineItems').addObject(lineItem)

  removeLineItem: (lineItem)->
    self = this
    customItem = lineItem.get('customItem')
    return new Em.RSVP.Promise (resolve, reject)->
      $.ajax "api/orders/#{self.get('number')}/line_items/#{lineItem.get('id')}",
        type: 'DELETE'
        datatype: 'json'
        data:
          order_token: self.get('token')
        success: ->
          if lineItem.get('variant')
            lineItem.get('variant').incrementProperty('totalInCart', -lineItem.get('quantity'))
          self.get('lineItems').removeObject(lineItem)
          unless customItem.content is null
            customItem.set 'state', 'precart'
            customItem.set 'lineItem', null
            customItem.content.save()
          resolve(self)
        error: (xhr)->
          if xhr.status is 404
            self.get('lineItems').removeRecord(lineItem)
            resolve(self)
          else
            reject(xhr)

  updateAddresses: (alertOnFailure)->
    self = this
    return new Em.RSVP.Promise (resolve, reject)->
      $.ajax "api/checkouts/#{self.get('number')}",
        type: "PUT"
        datatype: 'json'
        data:
          order_token: self.get('token')
          order: self.serializeAddresses()
        success: (payload)->
          self.store.pushPayload 'order',
            order: payload
          resolve(payload, self)
        error: (xhr, error, status)->
          if alertOnFailure
            message = ["#{xhr.responseJSON.error}\n"]
            $.each xhr.responseJSON.errors, (field, errs)->
              title = field.split('.')[1]
              errors = errs.join(', ')
              message.push "#{title}: #{errors}\n"
            alert(message.join('\n'))
          reject()

  serializeAddresses: ->
    if @get('useShippingAddress')
      payload =
        ship_address_attributes: @get('shipAddress').getAttributes()
        bill_address_attributes: @get('shipAddress').getAttributes()
    else
      payload =
        ship_address_attributes: @get('shipAddress').getAttributes()
        bill_address_attributes: @get('billAddress').getAttributes()
    return payload

  updateShipments: (alertOnFailure)->
    self = this
    return new Em.RSVP.Promise (resolve, reject)->
      $.ajax "api/checkouts/#{self.get('number')}",
        type: "PUT"
        datatype: 'json'
        data:
          order_token: self.get('token')
          order:
            shipments_attributes: self.serializeShipments()
        success: (payload)->
          self.store.pushPayload 'order',
            order: payload
          resolve(payload, self)
        error: (xhr, error, status)->
          if alertOnFailure
            message = ["#{xhr.responseJSON.error}\n"]
            $.each xhr.responseJSON.errors, (field, errs)->
              title = field.split('.')[1]
              errors = errs.join(', ')
              message.push "#{title}: #{errors}\n"
            alert(message.join('\n'))
          reject()

  serializeShipments: ->
    payload = {}
    $.each @get('shipments.currentState'), (index, shipment)->
      payload["#{index}"] =
        selected_shipping_rate_id: shipment.get 'selectedShippingId'
        id: shipment.get 'id'
    return payload

  getPaymentAttributes: ->
    self = this
    return new Em.RSVP.Promise (resolve, reject)->
      $.ajax "api/orders/#{self.get('number')}/payments/new",
        type: "GET"
        datatype: 'json'
        data:
          order_token: self.get('token')
        success: (payload)->
          resolve(payload)
        error: (xhr)->
          alert xhr.responseJSON.errors.base.join('\n')
          reject(xhr)

  createPayment: (paymentMethod, card)->
    self = this
    paymentMethodId = paymentMethod.get('id')
    return new Em.RSVP.Promise (resolve, reject)->
      return resolve() if self.get('state') is 'complete'
      paymentSource = {}
      paymentSource[paymentMethodId] =
        gateway_payment_profile_id: card.get('token')
      $.ajax "api/checkouts/#{self.get('number')}",
        type: "PUT"
        dataType: 'json'
        contentType: 'application/json'
        data: JSON.stringify
          order_token: self.get('token')
          order:
            payments_attributes: [
              payment_method_id: paymentMethodId
            ]
          payment_source: paymentSource
        success: (payload)->
          $.each payload.payments, (index, payment)->
            payment.orderId = self.get('id')
          self.store.pushPayload 'order',
            order: payload
          resolve(payload)
        error: (xhr)->
          alert xhr.responseJSON.errors.base.join('\n')
          card.clearData()
          reject(xhr)

  completePayment: ->
    self = this
    return new Em.RSVP.Promise (resolve, reject)->
      return resolve() if self.get('state') is not 'complete'
      $.ajax "api/checkouts/#{self.get('number')}",
        type: 'PUT'
        dataType: 'json'
        contentType: 'application/json'
        data: JSON.stringify
          order_token: self.get 'token'
        success: (payload)->
          self.store.pushPayload 'order',
            order: payload
          resolve(payload)
        error: (xhr)->
          alert xhr.responseJSON.errors.base.join('\n')
          reject(xhr)

