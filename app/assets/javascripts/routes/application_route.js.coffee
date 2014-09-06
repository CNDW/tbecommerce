App.ApplicationRoute = Em.Route.extend
  model: ->
    @store.createRecord 'lineItem',
      product: 'Messenger Bag'