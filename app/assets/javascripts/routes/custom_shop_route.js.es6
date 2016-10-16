App.CustomShopRoute = Em.Route.extend({
  model() {
    let { store } = this;
    let items = store.findAll('custom-item').filterBy('inShop', true);
    if (Em.isEmpty(items)) {
      let item = store.createRecord('custom-item', {
        inShop: true,
        shopState: 'new'
      });
      item.save();
      return item;
    } else {
      return items.get('firstObject');
    }
  },

  afterModel(model, transition) {
    return this.transitionTo('custom', model);
  }
});
