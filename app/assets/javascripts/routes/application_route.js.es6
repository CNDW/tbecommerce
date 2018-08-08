let { ORDER_TOKEN, ORDER_NUMBER } = App.CONSTANTS;

App.ApplicationRoute = Em.Route.extend({
  cart: Em.inject.service('cart'),
  model() {
    let { store } = this;
    return store.findAll('product').then(() => {
      return Em.RSVP.hash({
        customItems: store.findAll('custom-item'),
        order: this.get('cart').getOrder()
      });
    }).then((data) => {
      data.customItems.forEach((item) => {
        item.validateDataIntegrity();
      });
    }).catch(() => {
      Object.keys(App.CONSTANTS).forEach(k => localStorage.removeItem(k));
      this.refresh();
    });
  },

  actions: {
    openModal(template, model) {
      return this.render(template, {
        into: 'application',
        outlet: 'modal',
        controller: template,
        model
      });
    },

    closeModal() {
      return this.disconnectOutlet({
        outlet: 'modal',
        parentView: 'application'
      });
    },

    customBuilderWithProduct(product) {
      let item = this.store.createRecord('custom-item', {
        inShop: true,
        shop_state: 'colors'
      });
      item.set('productId', product.get('id'));
      item.reloadRelationships();
      item.save();
      return this.transitionTo('custom', item);
    },

//todo: refactor
    addToCart(item) {
      let self = this;
      if (item.get('inCart')) {
        item.set('inShop', false);
        item.save();
        this.transitionTo('cart');
        return;
      }
      let cart = this.get('cart');
      return cart.getOrder().then((order) => {
        return order.createLineItem(item).then(function() {
          if (item.isCustomItem) {
            item.set('inShop', false);
            item.save();
          }
          return self.transitionTo('cart');
        }, (xhr) => {
          let hasErrors = xhr.responseJSON && xhr.responseJSON.errors && xhr.responseJSON.errors.quantity;
          if (!item.isCustomItem && hasErrors) {
            alert('The item you tried to add to cart is no longer in stock');
          }
        });
      });
    }
  }
});
