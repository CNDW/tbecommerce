App.Order = DS.Model.extend
  #address info
  ship_firstname: DS.attr 'string'
  ship_lastname: DS.attr 'string'
  ship_address1: DS.attr 'string'
  ship_address2: DS.attr 'string'
  ship_email: Em.computed.alias 'email'
  ship_email_confirm: Em.computed.alias 'email_confirm'
  ship_city: DS.attr 'string'
  ship_zipcode: DS.attr 'string'
  ship_phone: DS.attr 'string'
  ship_state_name: DS.attr 'string'
  ship_alternative_phone: DS.attr 'string'
  ship_country_id: DS.attr 'number'
  ship_country: (->
    @store.getById 'country', @get 'ship_country_id'
  ).property('ship_country_id')
  ship_country_name: (->
    @get('ship_country.name')
  ).property('ship_country_id')
  ship_state_id: DS.attr 'number'
  ship_state: (->
    @store.getById 'state', @get 'ship_state_id'
  ).property('ship_state_id')
  ship_state_name: (->
    @get('ship_state.name')
  ).property('ship_state_id')

  bill_firstname: DS.attr 'string'
  bill_lastname: DS.attr 'string'
  bill_address1: DS.attr 'string'
  bill_address2: DS.attr 'string'
  bill_email: DS.attr 'string'
  bill_email_confirm: DS.attr 'string'
  bill_city: DS.attr 'string'
  bill_zipcode: DS.attr 'string'
  bill_phone: DS.attr 'string'
  bill_state_name: DS.attr 'string'
  bill_alternative_phone: DS.attr 'string'
  bill_country_id: DS.attr 'number'
  bill_country: (->
    @store.getById 'country', @get 'bill_country_id'
  ).property('bill_country_id')
  bill_country_name: (->
    @get('bill_country.name')
  ).property('bill_country_id')
  bill_state_id: DS.attr 'number'
  bill_state: (->
    @store.getById 'state', @get 'bill_state_id'
  ).property('bill_state_id')
  bill_state_name: (->
    @get('bill_state.name')
  ).property('bill_state_id')

  useShippingAddress: DS.attr 'boolean', defaultValue: no

  #order info
  ship_address: (->
    @addrAttrs('ship_')
  ).property()
  bill_address: (->
    if @get('useShippingAddress')
      return @addrAttrs('ship_')
    else
      return @addrAttrs('bill_')
  ).property()
  order_id: DS.attr 'number'
  email: DS.attr 'string'
  email_confirm: DS.attr 'string'
  special_instructions: DS.attr 'string'
  number: DS.attr 'string'
  token: DS.attr 'string', defaultValue: null
  total: DS.attr 'number'
  item_total: DS.attr 'number'
  ship_total: DS.attr 'number'
  included_tax_total: DS.attr 'number'
  additional_tax_total: DS.attr 'number'
  state: DS.attr 'string', defaultValue: 'precart'

  length: Em.computed.alias 'line_items.length'
  isEmpty: Em.computed.empty 'line_items'

  created: DS.attr 'boolean', defaultValue: false

  line_items: DS.hasMany 'line_items'

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
          self.save()
          item.remove()
          resolve(self)
        error: ->
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

  updateAddresses: ->
    $.ajax "api/checkouts/#{@get('number')}",
      type: "PUT"
      datatype: 'json'
      data:
        order_token: @get('token')
        order:
          @serializeAddresses()
      success: ->
        debugger
      error: ->
        debugger

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
      state_id: 29#@get "#{type}state_id"
      country_id: 49#@get "#{type}country_id"

  serializeLineItems: ->
    payload = {}

  serializeAddresses: ->
    payload =
      ship_address_attributes: @get('ship_address')
      bill_address_attributes: @get('bill_address')











