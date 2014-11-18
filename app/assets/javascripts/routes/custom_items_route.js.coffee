App.CustomItemsRoute = Em.Route.extend
  setupController: (controller, model)->
    @_super controller, model
    self = this
    Em.RSVP.hash
      categories: [
        name: 'bag'
        types: []
        models: @store.all('product').filterBy 'category', 'bag'
      ,
        name: 'apparel'
        types: []
        models: @store.all('product').filterBy 'category', 'apparel'
      ,
        name: 'utility'
        types: []
        models: @store.all('product').filterBy 'category', 'utility'
      ]
      order: @modelFor 'cart'
      featured: @store.all('product').filterBy 'featured', true
    .then (data)->

