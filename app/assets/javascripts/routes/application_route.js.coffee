App.ApplicationRoute = Em.Route.extend
  model: ->
    self = this
    store = @store
    model = @store.find('product').then ->
      Em.RSVP.hash
        customItems: store.find 'custom_item'
        carts: store.find 'cart'
      .then (data)->
        debugger
        carts = data.carts.filterBy('isCreated', true)
        if (carts.get('length') == 0)
          cart = store.createRecord 'cart',
            state: 'cart'
          cart.save()
        else
          cart = carts.shiftObject()
          cart.fetchOrder().then ->
            return cart
      , ->
        debugger
        localStorage.removeItem('TrashBagsCustomItem')
        localStorage.removeItem('TrashBagsCard')
        localStorage.removeItem('TrashBagsCart')
        self.refresh()

 #depricated
  getCart: ->
    carts = @store.find('cart').filterBy('created', true)
    if (carts.get('length') > 0)
      cart = carts.shiftObject()
    else
      cart = @store.createRecord 'cart',
        state: 'cart'
      cart.save()
    return cart

  actions:
    openModal: (template, model)->
      @render template,
        into: 'application'
        outlet: 'modal'
        model: model

    closeModal: ->
      @disconnectOutlet
        outlet: 'modal'
        parentView: 'application'

#todo: refactor
    addToCart: (item)->
      self = this
      if item.get 'inCart'
        item.set('inShop', false)
        item.save()
        @transitionTo 'cart'
        return
      cart = @modelFor 'application'
      order = @store.getById 'order', cart.get('order_id')
      order.createLineItem(item).then ->
        item.set('inShop', false)
        item.save()
        self.transitionTo 'cart'
