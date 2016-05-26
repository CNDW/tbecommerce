App.CartRoute = Em.Route.extend
  model: ->
    carts = @store.peekAll('cart').filterBy('isCreated', true)
    carts.get('firstObject.order')

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
