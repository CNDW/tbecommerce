App.LineItemController = Em.Controller.extend({
  itemImage: Em.computed.alias('model.variant.catalogueImage'),
  name: Em.computed.alias('model.variant.name')
});
