App.CartRoute = Em.Route.extend
  model: ->
    orders = @store.all('order').filterBy('created', true)
    if (orders.get('length') > 0)
      order = orders.shiftObject()
    else
      order = @store.createRecord 'order',
        state: 'cart'
      order.save()
    return order

  actions:
    removeFromCart: (lineItem)->
      self = this
      order = @modelFor('cart')
      order.removeLineItem(lineItem).then ->
        self.transitionTo 'cart'