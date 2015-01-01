App.Order = DS.Model.extend
  token: DS.attr 'string'
  number: DS.attr 'string'

  additional_tax_total: DS.attr 'string'
  adjustment_total: DS.attr 'string'
  channel: DS.attr 'string'
  completed_at: DS.attr 'string'
  created_at: DS.attr 'string'
  currency: DS.attr 'string'
  display_additional_tax_total: DS.attr 'string'
  display_included_tax_total: DS.attr 'string'
  display_item_total: DS.attr 'string'
  display_ship_total: DS.attr 'string'
  display_tax_total: DS.attr 'string'
  display_total: DS.attr 'string'
  email: DS.attr 'string'
  included_tax_total: DS.attr 'string'
  item_total: DS.attr 'string'
  line_items: DS.hasMany 'line_item'
  payment_state: DS.attr 'string'
  payment_total: DS.attr 'string'
  ship_total: DS.attr 'string'
  shipment_state: DS.attr 'string'
  special_instructions: DS.attr 'string'
  state: DS.attr 'string', defaultValue: 'cart'
  tax_total: DS.attr 'string'
  total: DS.attr 'string'
  total_quantity: Em.computed.alias 'line_items.length'
  updated_at: DS.attr 'string'

  ship_address: DS.belongsTo 'ship_address'
  bill_address: DS.belongsTo 'bill_address'

  shipments: DS.hasMany 'shipment'
  payments: DS.hasMany 'payment'
  payment_id: (->
    @get('payments.firstObject.id')
  ).property('payments.@each')
  orderHasPayment: Em.computed.notEmpty('payments')

  permissions: DS.attr 'object'
  # permissions: {can_update:false}
  # user_id: null
  # adjustments: []
  checkout_steps: DS.attr 'array'
  payment_methods: DS.hasMany 'payment_method'

  useShippingAddress: DS.attr 'boolean', defaultValue: no

  # #order info

  isEmpty: Em.computed.empty 'line_items'
  isComplete: (->
    @get('checkoutStep') > 3
  ).property('checkoutStep')

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

  checkoutStep: (->
    @get('checkoutSteps')[@get('state')]
  ).property('state')

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
        reject(self)
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
            variant_id: item.get('variant_id')
            custom_item_hash: item.get('custom_item_hash')
            order_notes: item.get('order_notes')
        success: (data)->
          if item.isCustomItem
            data.customItem = item
          self.store.pushPayload 'line_item',
            line_item: data
          self.addLineItem data.id
          resolve(self, data)
        error: (xhr)->
          reject(xhr)

  addLineItem: (line_item_id)->
    line_item = @store.getById 'line_item', line_item_id
    @get('line_items').addObject(line_item)

  removeLineItem: (line_item)->
    self = this
    custom_item = line_item.get('customItem')
    return new Em.RSVP.Promise (resolve, reject)->
      $.ajax "api/orders/#{self.get('number')}/line_items/#{line_item.get('id')}",
        type: 'DELETE'
        datatype: 'json'
        data:
          order_token: self.get('token')
        success: ->
          if line_item.get('variant')
            line_item.get('variant').incrementProperty('total_in_cart', -line_item.get('quantity'))
          self.get('line_items').removeObject(line_item)
          unless custom_item.content is null
            custom_item.set 'state', 'precart'
            custom_item.set 'line_item', null
            custom_item.content.save()
          resolve(self)
        error: (xhr)->
          if xhr.status is 404
            self.get('line_items').removeRecord(line_item)
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
          reject(self)

  serializeAddresses: ->
    if @get('useShippingAddress')
      payload =
        ship_address_attributes: @get('ship_address').getAttributes()
        bill_address_attributes: @get('ship_address').getAttributes()
    else
      payload =
        ship_address_attributes: @get('ship_address').getAttributes()
        bill_address_attributes: @get('bill_address').getAttributes()
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
          reject(self)

  serializeShipments: ->
    shipments_attributes = {}
    $.each @get('shipments.currentState'), (index, shipment)->
      shipments_attributes["#{index}"] =
        selected_shipping_rate_id: shipment.get 'selected_shipping_id'
        id: shipment.get 'id'
    return shipments_attributes

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

  createPayment: (payment_method, card)->
    self = this
    payment_method_id = payment_method.get('id')
    return new Em.RSVP.Promise (resolve, reject)->
      return resolve() if self.get('state') is 'complete'
      payment_source = {}
      payment_source[payment_method_id] =
        gateway_payment_profile_id: card.get('token')
      $.ajax "api/checkouts/#{self.get('number')}",
        type: "PUT"
        dataType: 'json'
        contentType: 'application/json'
        data: JSON.stringify
          order_token: self.get('token')
          order:
            payments_attributes: [
              payment_method_id: payment_method_id
            ]
          payment_source: payment_source
        success: (payload)->
          $.each payload.payments, (index, payment)->
            payment.order_id = self.get('id')
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

