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

  order: DS.belongsTo 'order'
  # manifest: [{quantity:1, states:{backordered:1}, variant_id:21}]
  # selected_shipping_rate: {id:32, name:dog courier, cost:0.0, selected:true, shipping_method_id:2, display_cost:$0.00}
  # shipping_rates: [{id:32, name:dog courier, cost:0.0, selected:true, shipping_method_id:2, display_cost:$0.00},…]

  line_items: Em.computed 'order.line_items', 'manifest', ->
    self = this
    @get('order.line_items').filter (item, index)->
      self.get('manifest').mapBy('custom_item_hash').contains(item.get('custom_item_hash'))
