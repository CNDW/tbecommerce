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

  ship_address: DS.attr 'object', defaultValue: address_attributes
  bill_address: DS.attr 'object', defaultValue: address_attributes

  ship_states_required: (->
    country = @get('ship_country')
    if country
      country.get('states_required')
    else
      false
  ).property('ship_country')
  ship_country: (->
    @store.getById('country', @get('ship_address.country_id'))
  ).property('ship_address.country_id')
  bill_states_required: (->
    country = @get('bill_country')
    if country
      country.get('states_required')
    else
      false
  ).property('bill_country')
  bill_country: (->
    @store.getById('country', @get('bill_address.country_id'))
  ).property('bill_address.country_id')
  address_attributes =
    firstname: ''
    lastname: ''
    address1: ''
    address2: ''
    email: ''
    city: ''
    phone: ''
    zipcode: ''
    state_id: ''
    country_id: ''

  shipments: DS.hasMany 'shipment'
  # payments: []
  # permissions: {can_update:false}
  # user_id: null
  # adjustments: []
  # checkout_steps: [address, delivery, complete]

  useShippingAddress: DS.attr 'boolean', defaultValue: yes

  # #order info

  isEmpty: Em.computed.empty 'line_items'

  checkoutStates: [
    'cart'
    'address'
    'delivery'
    'payment'
    'complete'
  ]
  checkoutSteps:
    cart: 0
    address: 1
    delivery: 2
    payment: 3
    complete: 4

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
          order:
            self.serializeAddresses()
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
        ship_address_attributes: @get('ship_address')
        bill_address_attributes: @get('ship_address')
    else
      payload =
        ship_address_attributes: @get('ship_address')
        bill_address_attributes: @get('bill_address')
    delete payload.ship_address_attributes.country
    delete payload.ship_address_attributes.state
    delete payload.bill_address_attributes.country
    delete payload.bill_address_attributes.state
    return payload

# Old ---------------------------




#=====================================================
# API communcation
#=====================================================


  serializeLineItems: ->
    payload = {}




  updateShipments: (shipmentJSON)->
    debugger

