App.ApplicationRoute = Em.Route.extend
  model: ->
    self = this
    store = @store
    model = @store.find('product').then ->
      Em.RSVP.hash
        customOptions: store.find 'custom_option'
        customItems: store.find 'custom_item'
        selectedColors: store.find 'selected_color'
        carts: store.find 'cart'
      .then (data)->
        carts = data.carts.filterBy('isCreated', true)
        if (carts.get('length') == 0)
          cart = store.createRecord 'cart',
            state: 'cart'
          cart.save()
        else
          cart = carts.shiftObject()
      , ->
        localStorage.removeItem('TrashBags')
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
      order = @getCart()
      record = @store.createRecord 'line_item',
        product: item.get('product'),
        customItem: item
        order: order
      order.addLineItem(record).then ->
        record.save()
        item.set('inShop', false)
        item.save()
        self.transitionTo 'cart'

    checkout: (order)->
      self = this
      return if order.get('length') is 0
      order.advanceState(1).then ->
        self.transitionTo 'order', order

