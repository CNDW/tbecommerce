App.CustomIndexRoute = Em.Route.extend({
  afterModel(model, transition) {
    let state = model.get('shopState');
    switch (state) {
      case 'new': return this.transitionTo('custom.product');
      case 'colors': return this.transitionTo('custom.colors');
      case 'options': return this.transitionTo('custom.options');
      case 'extras': return this.transitionTo('custom.options');
      case 'complete': return this.transitionTo('custom.options');
      default: return this.transitionTo('custom.product');
    }
  }
});
