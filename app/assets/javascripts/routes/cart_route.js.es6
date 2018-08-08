App.CartRoute = Em.Route.extend({
  cart: Em.inject.service('cart'),
  model() {
    let cart = this.get('cart');
    return cart.getOrder();
  },

  actions: {
    checkout(order) {
      let self = this;
      if (order.get('totalQuantity') === 0) { return; }
      return order.advanceState('address').then(() => self.transitionTo('order', order));
    }
  }
});
