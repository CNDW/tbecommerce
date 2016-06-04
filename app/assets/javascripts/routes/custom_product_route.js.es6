App.CustomProductRoute = Em.Route.extend({

  actions: {
    setCustomProduct(product) {
      let customItem = this.modelFor('custom');
      customItem.set('productId', product.get('id'));
      customItem.reloadRelationships();
      return this.transitionTo('custom.colors', customItem);
    }
  }
});
