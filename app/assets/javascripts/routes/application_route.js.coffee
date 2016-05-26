App.ApplicationRoute = Em.Route.extend
  model: ->
    self = this
    store = @store
    model = @store.findAll('product').then ->
      Em.RSVP.hash
        customItems: store.findAll 'custom_item'
        carts: store.findAll 'cart'
      .then (data)->
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
    carts = @store.findAll('cart').filterBy('created', true)
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
        controller: template
        model: model

    closeModal: ->
      @disconnectOutlet
        outlet: 'modal'
        parentView: 'application'

    customBuilderWithProduct: (product)->
      item = @store.createRecord 'custom_item',
        inShop: true
        shop_state: 'colors'
      item.set('product_id', product.get('id'))
      item.reloadRelationships()
      item.save()
      @transitionTo 'custom', item

#todo: refactor
    addToCart: (item)->
      self = this
      if item.get 'inCart'
        item.set('inShop', false)
        item.save()
        @transitionTo 'cart'
        return
      cart = @modelFor 'application'
      order = cart.get 'order'
      order.createLineItem(item).then ->
        if item.isCustomItem
          item.set('inShop', false)
          item.save()
        self.transitionTo 'cart'
      , (xhr)->
        unless item.isCustomItem and not (xhr.responseJSON.errors && xhr.responseJSON.errors.quantity)
          alert 'The item you tried to add to cart is no longer in stock'
