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
  manifest: DS.hasMany 'manifest'
  # manifest: [{quantity:1, states:{backordered:1}, variant_id:21}]
  # selected_shipping_rate: {id:32, name:dog courier, cost:0.0, selected:true, shipping_method_id:2, display_cost:$0.00}
  # shipping_rates: [{id:32, name:dog courier, cost:0.0, selected:true, shipping_method_id:2, display_cost:$0.00},…]
