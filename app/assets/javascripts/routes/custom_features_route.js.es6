App.CustomFeaturesRoute = Em.Route.extend({
  afterModel(model) {
    if (model.get('completedStep') < 2) { 
      return this.transitionTo('custom.colors', model); 
    }
  }
});
