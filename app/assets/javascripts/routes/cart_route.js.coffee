App.CartRoute = Em.Route.extend
  model: ->
    orders = @store.all('order').filterBy('state', 'cart')
    if (orders.get('length') > 0)
      order = orders.shiftObject()
      orders.setEach('state', 'precart')
    else
      order = @store.createRecord 'order',
        state: 'cart'
      order.save()
    return order
