Trashbags.CartRoute = Em.Route.extend
  model: ->
    @store.find 'cart'