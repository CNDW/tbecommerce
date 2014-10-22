App.ApplicationRoute = Em.Route.extend
  model: ->
    store = @store
    products = @store.find('product').then ->
      Em.RSVP.hash
        customOptions: store.find 'custom_option'
        customItems: store.find 'custom_item'
        selectedColors: store.find 'selected_color'
        lineItems: store.find 'line_item'
        orders: store.find 'order'

  getCartOrder: ->
    orders = @store.all('order').filterBy('created', true)
    if (orders.get('length') > 0)
      order = orders.shiftObject()
    else
      order = @store.createRecord 'order',
        state: 'cart'
      order.save()
    return order

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

    addToCart: (item)->
      self = this
      if item.get 'inCart'
        item.set('inShop', false)
        item.save()
        @transitionTo 'cart'
        return
      order = @getCartOrder()
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
      order.set 'state', 'address'
      order.save()
      @transitionTo 'order', order

