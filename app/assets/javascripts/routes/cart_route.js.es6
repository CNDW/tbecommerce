App.CartRoute = Em.Route.extend({
  model() {
    let carts = this.store.peekAll('cart').filterBy('isCreated', true);
    return carts.get('firstObject.order');
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
