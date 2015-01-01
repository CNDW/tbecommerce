App.Shipment = DS.Model.extend
  cost: DS.attr 'string'
  number: DS.attr 'string'
  order_id: DS.attr 'string'
  shipped_at: DS.attr 'string'
  shipping_methods: DS.hasMany 'shipping_method'
  state: DS.attr 'string'
  stock_location_name: DS.attr 'string'
  tracking: DS.attr 'string'
  shipping_rates: DS.hasMany 'shipping_rate'
  selected_shipping_rate: DS.belongsTo 'shipping_rate'

  selected_shipping_id: Em.computed.alias 'selected_shipping_rate.id'
  manifest: DS.attr 'array'
