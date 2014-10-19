App.Order = DS.Model.extend
  ship_address: DS.attr 'string'
  email: DS.attr 'string'
  special_instructions: DS.attr 'string'
  number: DS.attr 'string'
  token: DS.attr 'string'
  total: DS.attr 'number'
  item_total: DS.attr 'number'
  ship_total: DS.attr 'number'
  included_tax_total: DS.attr 'number'
  additional_tax_total: DS.attr 'number'
  state: DS.attr 'string', default: 'cart'

  line_items: DS.hasMany 'line_items'

  didCreate: ->
    debugger
