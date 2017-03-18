App.Shipment = DS.Model.extend({
  cost: DS.attr('string'),
  number: DS.attr('string'),
  orderId: DS.attr('string'),
  shippedAt: DS.attr('string'),
  shippingMethods: DS.hasMany('shipping-method'),
  state: DS.attr('string'),
  stockLocationName: DS.attr('string'),
  tracking: DS.attr('string'),
  shippingRates: DS.hasMany('shipping-rate'),
  selectedShippingRate: DS.belongsTo('shipping-rate'),

  selectedShippingId: Em.computed.alias('selectedShippingRate.id'),
  manifest: DS.attr('array')
});
