App.CartRoute = Em.Route.extend
  model: ->
    carts = @store.all('cart').filterBy('isCreated', true)
    cart = carts.shiftObject()
    cart.get('order')


  actions:
    removeFromCart: (lineItem)->
      self = this
      order = @modelFor('cart')
      order.removeLineItem(lineItem).then ->
        self.refresh()

    checkout: (order)->
      self = this
      return if order.get('total_quantity') is 0
      order.advanceState('address').then ->
        self.transitionTo 'order', order