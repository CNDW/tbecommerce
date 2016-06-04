App.ShippingRate = DS.Model.extend
  cost: DS.attr 'string'
  displayCost: DS.attr 'string'
  name: DS.attr 'string'
  selected: DS.attr 'boolean'
  shippingMethod: DS.belongsTo 'shippingMethod'
