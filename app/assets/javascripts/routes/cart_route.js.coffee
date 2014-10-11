App.CartRoute = Em.Route.extend
  model: ->
    @store.find 'line_item'