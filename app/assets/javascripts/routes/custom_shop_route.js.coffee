Trashbags.CustomShopRoute = Em.Route.extend
  model: ->
    @store.find('product')