App.Order = DS.Model.extend
  #address info
  ship_firstname: DS.attr 'string', defaultValue: null
  ship_lastname: DS.attr 'string', defaultValue: null
  ship_address1: DS.attr 'string', defaultValue: null
  ship_address2: DS.attr 'string', defaultValue: null
  ship_email: Em.computed.alias 'email'
  ship_email_confirm: Em.computed.alias 'email_confirm'
  ship_city: DS.attr 'string', defaultValue: null
  ship_zipcode: DS.attr 'string', defaultValue: null
  ship_phone: DS.attr 'string', defaultValue: null
  ship_state_name: DS.attr 'string', defaultValue: null
  ship_alternative_phone: DS.attr 'string', defaultValue: null
  ship_country_id: DS.attr 'number', defaultValue: null
  ship_country: (->
    @store.getById 'country', @get 'ship_country_id'
  ).property('ship_country_id')
  ship_country_name: (->
    @get('ship_country.name')
  ).property('ship_country_id')
  ship_state_id: DS.attr 'number', defaultValue: null
  ship_state: (->
    @store.getById 'state', @get 'ship_state_id'
  ).property('ship_state_id')
  ship_state_name: (->
    @get('ship_state.name')
  ).property('ship_state_id')
  ship_states_required: (->
    @get('ship_country.states_required')
  ).property('ship_country_id')

  bill_firstname: DS.attr 'string', defaultValue: null
  bill_lastname: DS.attr 'string', defaultValue: null
  bill_address1: DS.attr 'string', defaultValue: null
  bill_address2: DS.attr 'string', defaultValue: null
  bill_email: DS.attr 'string', defaultValue: null
  bill_email_confirm: DS.attr 'string', defaultValue: null
  bill_city: DS.attr 'string', defaultValue: null
  bill_zipcode: DS.attr 'string', defaultValue: null
  bill_phone: DS.attr 'string', defaultValue: null
  bill_state_name: DS.attr 'string', defaultValue: null
  bill_alternative_phone: DS.attr 'string', defaultValue: null
  bill_country_id: DS.attr 'number', defaultValue: null
  bill_country: (->
    @store.getById 'country', @get 'bill_country_id'
  ).property('bill_country_id')
  bill_country_name: (->
    @get('bill_country.name')
  ).property('bill_country_id')
  bill_state_id: DS.attr 'number', defaultValue: null
  bill_state: (->
    @store.getById 'state', @get 'bill_state_id'
  ).property('bill_state_id')
  bill_state_name: (->
    @get('bill_state.name')
  ).property('bill_state_id')
  bill_states_required: (->
    @get('bill_country.states_required')
  ).property('bill_country_id')

  useShippingAddress: DS.attr 'boolean', defaultValue: no

  #order info

  order_id: DS.attr 'number'
  email: DS.attr 'string', defaultValue: null
  email_confirm: DS.attr 'string', defaultValue: null
  special_instructions: DS.attr 'string', defaultValue: null
  number: DS.attr 'string', defaultValue: null
  token: DS.attr 'string', defaultValue: null
  total: DS.attr 'number'
  item_total: DS.attr 'number'
  ship_total: DS.attr 'number'
  included_tax_total: DS.attr 'number'
  additional_tax_total: DS.attr 'number'
  state: DS.attr 'string', defaultValue: 'precart'

  length: Em.computed.alias 'line_items.length'
  isEmpty: Em.computed.empty 'line_items'

  created: DS.attr 'boolean', defaultValue: no
  completed: DS.attr 'boolean', defaultValue: no

  line_items: DS.hasMany 'line_items'
  isDirty: DS.attr 'boolean', defaultValue: no

  checkoutSteps: [
    'cart'
    'address'
    'delivery'
    'payment'
    'complete'
  ]
  checkoutCompleted: (->
    @get('checkoutSteps').indexOf(@get('state'))
  ).property('state')

  didCreate: ->
    if @get('token') is null
      @createOrder()

  addLineItem: (item)->
    self = this
    return new Promise (resolve, reject)->
      $.ajax "api/orders/#{self.get('number')}/line_items",
        type: "POST"
        datatype: 'json'
        data:
          order_token: self.get('token')
          line_item: variant_id: item.get('variant_id')
        success: (data)->
          self.get('line_items').addRecord(item)
          item.set('line_item_id', data.id)
          item.save()
          self.save()
          resolve(self)
        error: ->
          reject(arguments)

  removeLineItem: (item)->
    self = this
    return new Promise (resolve, reject)->
      $.ajax "api/orders/#{self.get('number')}/line_items/#{item.get('line_item_id')}",
        type: 'DELETE'
        datatype: 'json'
        success: ->
          self.get('line_items').removeRecord(item)
          self.set 'state', 'cart'
          self.save()
          item.remove()
          resolve(self)
        error: (xhr)->
          if xhr.status is 404
            self.get('line_items').removeRecord(item)
            self.save()
            item.remove()
          reject(arguments)

#=====================================================
# API communcation
#=====================================================
  createOrder: ->
    return if @get 'created'
    self = this
    $.post 'api/orders', {}, (payload, status, xhr)->
      self.eachAttribute (name, meta)->
        if name == 'order_id'
          self.set 'order_id', payload.id
        else
          self.set name, payload[name]
      self.set('created', true)
      self.save()

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
        success: ->
          self.set 'isDirty', no
          resolve(self)
        error: (xhr, error, status)->
          if alertOnFailure
            message = ["#{xhr.responseJSON.error}\n"]
            $.each xhr.responseJSON.errors, (field, errs)->
              title = field.split('.')[1]
              errors = errs.join(', ')
              message.push "#{title}: #{errors}\n"
            alert(message.join('\n'))
          reject(self)

  updateLineItems: ->
    order_token = @get('token')
    order_id = @get('order_id')
    @get('line_items').forEach (line_item)->
      if line_item.get('isDirty')
        $.ajax "api/orders/#{order_id}/line_items",
          type: "POST"
          dataType: "json"
          data:
            order:
              order_token: order_token
            line_item:
              variant_id: line_item.get('variant_id')
          success: ->
            line_item.set('isDirty', false)
            line_item.save()

  advanceState: (targetState)->
    self = this
    if @get('checkoutCompleted') == (targetState - 1)
      return new Promise (resolve, reject)->
        $.ajax "api/checkouts/#{self.get('number')}/next",
          type: "PUT"
          dataType: "json"
          data:
            order_token: self.get('token')
          success: (order)->
            self.set 'state', order.state
            self.save()
            resolve(order)
          error: ->
            debugger
            reject(arguments)
    else
      return new Promise (resolve, reject)->
        if self.get('checkoutCompleted') >= targetState
          resolve(self)
        else if !self.get('state')
          $.ajax "api/checkouts/#{self.get('number')}",
            type: "GET"
            dataType: "json"
            data:
              order_token: self.get('token')
            success: (order)->
              self.set 'state', order.state
              self.save()
              resolve(order)
            error: ->
              reject(arguments)

  addrAttrs: (type)->
    attrs =
      firstname: @get "#{type}firstname"
      lastname: @get "#{type}lastname"
      address1: @get "#{type}address1"
      address2: @get "#{type}address2"
      city: @get "#{type}city"
      email: @get "#{type}email"
      phone: @get "#{type}phone"
      zipcode: @get "#{type}zipcode"
      state_id: @get "#{type}state_id"
      country_id: @get "#{type}country_id"

  serializeLineItems: ->
    payload = {}

  serializeAddresses: ->
    payload =
      ship_address_attributes: @getShipAddress(this)
      bill_address_attributes: @getBillAddress(this)

  getShipAddress: (order)->
    order.addrAttrs('ship_')
  getBillAddress: (order)->
    if order.get('useShippingAddress')
      return order.addrAttrs('ship_')
    else
      return order.addrAttrs('bill_')
