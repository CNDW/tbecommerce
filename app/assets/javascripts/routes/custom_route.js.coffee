App.CustomRoute = Em.Route.extend

  afterModel: (model, transition)->
    controller = @controllerFor('custom')
    if !model.get('hasProduct')
      controller.set 'builderStep', 1

  actions:
    error: ->
      @transitionTo('custom_shop')
