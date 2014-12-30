App.CustomColorsRoute = Em.Route.extend

  afterModel: (model, transition)->
    transition.abort() if model.get('completedStep') < 1

App.CustomFeaturesRoute = Em.Route.extend

  afterModel: (model, transition)->
    transition.abort() if model.get('completedStep') < 2