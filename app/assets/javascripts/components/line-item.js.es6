App.LineItemComponent = Em.Component.extend({
  cart: Em.inject.service('cart'),
  itemImage: Em.computed.alias('model.variant.catalogueImage'),
  name: Em.computed.alias('model.variant.name'),

  actions: {
    removeFromCart() {
      this.get('cart').removeFromCart(this.get('model'));
    }
  }
});
