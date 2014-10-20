App.Order = DS.Model.extend
  ship_address: DS.attr 'string'
  email: DS.attr 'string'
  special_instructions: DS.attr 'string'
  number: DS.attr 'string'
  token: DS.attr 'string', defaultValue: null
  total: DS.attr 'number'
  item_total: DS.attr 'number'
  ship_total: DS.attr 'number'
  included_tax_total: DS.attr 'number'
  additional_tax_total: DS.attr 'number'
  state: DS.attr 'string', defaultValue: 'cart'

  created: (->
    @get('token') != null
  ).property('token')

  line_items: DS.hasMany 'line_items'

  didCreate: ->
    if @get('token') is null
      @createOrder()

  createOrder: ->
    return if @get 'created'
    self = this
    $.post 'api/orders', {}, (payload, status, xhr)->
      self.eachAttribute (name, meta)->
        self.set name, payload[name]
      self.save()
