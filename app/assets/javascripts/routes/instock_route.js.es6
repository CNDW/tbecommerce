App.InstockRoute = Em.Route.extend({
  model() {
    return this.store.findAll('variant');
  }
});

App.InstockItemRoute = Em.Route.extend({
  model(params) {
    return this.store.find('variant', params.variant_id);
  }
});
