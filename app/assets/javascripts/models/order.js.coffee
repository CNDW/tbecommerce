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
  ship_country: DS.attr 'string'

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
  bill_country: DS.attr 'string'

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

  created: (->
    @get('token') != null
  ).property('token')

  line_items: DS.hasMany 'line_items'

  didCreate: ->
    if @get('token') is null
      @createOrder()

  addLineItem: (item)->
    @get('line_items').addRecord(item)
    @save()

  removeLineItem: (item)->
    @get('line_items').removeRecord(item)
    @save()

#=====================================================
# API communcation
#=====================================================
  createOrder: ->
    return if @get 'created'
    self = this
    $.post 'api/orders', {}, (payload, status, xhr)->
      self.eachAttribute (name, meta)->
        self.set name, payload[name]
      self.save()

  updateAddresses: ->
    data = @serializeAddresses()
    $.ajax "api/checkouts/#{@get('number')}.json",
      type: "PUT"
      data: {order_token: @get('token')}
      contents: @serializeAddresses()
      success: ->
        debugger

  addrAttrs: (type)->
    attrs =
      firstname: @get 'firstname'
      lastname: @get 'lastname'
      address1: @get 'address1'
      address2: @get 'address2'
      city: @get 'city'
      email: @get 'email'
      phone: @get 'phone'
      zipcode: @get 'zipcode'
      state_id: @get 'state_id'
      country_id: @get 'country_id'


  serializeAddresses: ->
    payload =
      order:
        ship_address_attributes: @get('ship_address')
        bill_address_attributes: @get('bill_address')











