App.CartRoute = Em.Route.extend
  model: ->
    @getCartOrder()

  getCartOrder: ->
    orders = @store.all('order').filterBy('state', 'cart')
    if (orders.get('length') > 0)
      order = orders.shiftObject()
      orders.setEach('state', 'precart')
    else
      order = @store.createRecord 'order'
      order.save()
    return order
