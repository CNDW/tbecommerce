App.InstockRoute = Em.Route.extend
  model: ->
    @store.find 'variant'