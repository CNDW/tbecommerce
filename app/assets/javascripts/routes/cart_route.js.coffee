App.CartRoute = Em.Route.extend
  model: ->
    @store.all('line_item')