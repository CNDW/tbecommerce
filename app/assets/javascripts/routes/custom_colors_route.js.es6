App.CustomColorsRoute = Em.Route.extend({

  afterModel(model, transition) {
    if (model.get('completedStep') < 1) { return transition.abort(); }
  }
});

App.CustomFeaturesRoute = Em.Route.extend({

  afterModel(model, transition) {
    if (model.get('completedStep') < 2) { return transition.abort(); }
  }
});
