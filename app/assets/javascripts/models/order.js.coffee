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

  checkoutStates: [
    'cart'
    'address'
    'delivery'
    'payment'
    'confirm'
    'complete'
  ]
  checkoutSteps:
    cart: 0
    address: 1
    delivery: 2
    payment: 3
    confirm: 4
    complete: 5

  checkoutStep: (->
    @get('checkoutSteps')[@get('state')]
  ).property('state')

  advanceState: (targetState)->
    targetStep = @get('checkoutSteps')[targetState]
    currentStep = @get('checkoutStep')
    self = this
    return new Promise (resolve, reject)->
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
          error: ->
            debugger
            reject(arguments)
      else if targetStep > currentStep + 1
        reject(self)
      else
        resolve(self)

  createLineItem: (item)->
    self = this
    return new Promise (resolve, reject)->
      $.ajax "api/orders/#{self.get('number')}/line_items",
        type: "POST"
        datatype: 'json'
        data:
          order_token: self.get('token')
          line_item:
            variant_id: item.get('variant_id')
            custom_item_hash: item.get('custom_item_hash')
        success: (data)->
          data.customItem = item
          self.store.pushPayload 'line_item',
            line_item: data
          self.addLineItem data.id
          resolve(self, data)
        error: ->
          reject(arguments)

  addLineItem: (line_item_id)->
    line_item = @store.getById 'line_item', line_item_id
    @get('line_items').addObject(line_item)

  removeLineItem: (line_item)->
    self = this
    custom_item = line_item.get('customItem')
    return new Promise (resolve, reject)->
      $.ajax "api/orders/#{self.get('number')}/line_items/#{line_item.get('id')}",
        type: 'DELETE'
        datatype: 'json'
        data:
          order_token: self.get('token')
        success: ->
          self.get('line_items').removeObject(line_item)
          custom_item.set 'state', 'precart'
          custom_item.set 'line_item', null
          custom_item.save()
          resolve(self)
        error: (xhr)->
          if xhr.status is 404
            self.get('line_items').removeRecord(line_item)
            resolve(self)
          else
            reject(arguments)

  updateAddresses: (alertOnFailure)->
    self = this
    return new Promise (resolve, reject)->
      $.ajax "api/checkouts/#{self.get('number')}",
        type: "PUT"
        datatype: 'json'
        data:
          order_token: self.get('token')
          order: self.serializeAddresses()
        success: (orderResponse)->
          resolve(orderResponse, self)
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
    return new Promise (resolve, reject)->
      $.ajax "api/checkouts/#{self.get('number')}",
        type: "PUT"
        datatype: 'json'
        data:
          order_token: self.get('token')
          order: self.serializeShipments()
        success: (orderResponse)->
          resolve(orderResponse, self)
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
    $.each @get('shipments.content'), (index, shipment)->
      shipments_attributes["#{index}"] =
        selected_shipping_rate_id: shipment.get 'selected_shipping_id'
        id: shipment.get 'id'
    return shipments_attributes

  getPaymentAttributes: ->
    self = this
    return new Promise (resolve, reject)->
      $.ajax "api/orders/#{self.get('number')}/payments/new",
        type: "GET"
        datatype: 'json'
        data:
          order_token: self.get('token')
        success: (payload)->
          resolve(payload)
        error: ->
          debugger

  createPayment: (payment_method_id, card)->
    self = this
    return new Promise (resolve, reject)->
      $.ajax "api/orders/#{self.get('number')}/payments",
        type: "POST"
        datatype: 'json'
        data:
          order_token: self.get('token')
          payment:
            payment_method_id: payment_method_id
            amount: Number(self.get('total'))
            creditcard: card.get('number')
        success: (payload)->
          payload.order_id = self.get('id')
          self.store.pushPayload 'payment',
            payment: payload
          resolve(payload)
        error: ->
          reject(arguments)
          debugger

  purchaseOrder: (card)->
    self = this
    return new Promise (resolve, reject)->
      $.ajax "api/orders/#{self.get('number')}/payments/#{self.get('payment_id')}/purchase",
        type: "PUT"
        datatype: 'json'
        data:
          order_token: self.get('token')
          creditcard: card.get('token')
          money: self.get('total')
        success: (payload)->
          debugger
          resolve()
        error: ->
          debugger
          reject(arguments)
# Old ---------------------------




#=====================================================
# API communcation
#=====================================================


  serializeLineItems: ->
    payload = {}





