App.CustomRoute = Em.Route.extend

  actions:
    error: ->
      @transitionTo('custom_shop')
