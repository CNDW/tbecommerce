App.CustomColorsRoute = Em.Route.extend({
  afterModel(model) {
    if (model.get('completedStep') < 1) { 
      return this.transitionTo('custom.product', model); 
    }
  }
});
