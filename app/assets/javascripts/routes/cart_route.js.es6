App.CartRoute = Em.Route.extend({
  cart: Em.service.inject('cart'),
  model() {
    let cart = this.get('cart');
    return cart.getOrder();
  },

  actions: {
    removeFromCart(lineItem) {
      let self = this;
      let order = this.modelFor('cart');
      return order.removeLineItem(lineItem).then(() => self.refresh());
    },

    checkout(order) {
      let self = this;
      if (order.get('totalQuantity') === 0) { return; }
      return order.advanceState('address').then(() => self.transitionTo('order', order));
    }
  }
});
