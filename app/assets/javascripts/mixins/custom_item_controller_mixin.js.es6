App.CustomItemControllerMixin = Em.Mixin.create({
  price: Em.computed.alias('model.price'),
  name: Em.computed.alias('model.name')
});