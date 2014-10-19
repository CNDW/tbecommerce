App.CartRoute = Em.Route.extend
  model: ->
    @store.all('line_item').filter (item)->
      item.get('customItem.inCart') and item.get('customItem.isComplete')
