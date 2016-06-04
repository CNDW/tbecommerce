App.Shipment = DS.Model.extend
  cost: DS.attr 'string'
  number: DS.attr 'string'
  orderId: DS.attr 'string'
  shippedAt: DS.attr 'string'
  shippingMethods: DS.hasMany 'shippingMethod'
  state: DS.attr 'string'
  stockLocationName: DS.attr 'string'
  tracking: DS.attr 'string'
  shippingRates: DS.hasMany 'shippingRate'
  selectedShippingRate: DS.belongsTo 'shippingRate'

  selectedShippingId: Em.computed.alias 'selectedShippingRate.id'
  manifest: DS.attr 'array'
