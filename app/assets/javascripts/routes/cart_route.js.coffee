App.CartRoute = Em.Route.extend
  model: ->
    self = this
    cart = @modelFor 'application'
    cart.get 'order'

  setupController: ->
    console.log 'cartrout setupController'

  actions:
    removeFromCart: (lineItem)->
      self = this
      order = @modelFor('cart')
      order.removeLineItem(lineItem).then ->
        self.refresh()