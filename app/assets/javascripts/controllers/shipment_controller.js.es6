App.ShipmentController = Em.Controller.extend({
  needs: ['order'],
  radio_name: Em.computed(function() {
    return `shipment-radio-${this.get('model.id')}`;
  }),
  order: Em.computed.alias('controllers.order.model'),
  line_items: Em.computed(function() {
    let manifest = this.get('model.manifest');
    return this.get('order.line_items').filter((item, index)=> manifest.mapBy('custom_item_hash').contains(item.get('custom_item_hash')));
  })
});
