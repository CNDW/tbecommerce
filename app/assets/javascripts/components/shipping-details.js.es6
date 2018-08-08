App.ShippingDetailsComponent = Em.Component.extend({
  orderController: Em.inject.controller('order'),
  radioName: Em.computed(function() {
    return `shipment-radio-${this.get('model.id')}`;
  }),
  order: Em.computed.alias('orderController.model'),
  lineItems: Em.computed(function() {
    let manifest = this.get('model.manifest');
    return this.get('order.lineItems')
      .filter((item, index) => {
        return manifest
          .mapBy('customItemHash')
          .contains(item.get('customItemHash'));
      });
  })
});
