App.ShippingRate = DS.Model.extend
  cost: DS.attr 'string'
  display_cost: DS.attr 'string'
  name: DS.attr 'string'
  selected: DS.attr 'boolean'
  shipping_method: DS.belongsTo 'shipping_method'
