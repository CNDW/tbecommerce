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

  setupController: (controller, model)->
    controller.set('cartOrder', @getCartOrder())

  getCartOrder: ->
    orders = @store.all('order').filterBy('state', 'cart')
    if (orders.get('length') > 0)
      order = orders.shiftObject()
      orders.setEach('state', 'precart')
    else
      order = @store.createRecord 'order'
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
      if item.get 'inCart'
        item.save()
        @transitionTo 'cart'
        return
      order = @controllerFor('application').get('cartOrder')
      record = @store.createRecord 'line_item',
        product: item.get('product'),
        customItem: item
        order: order
      record.save()
      order.addLineItem(record)
      item.save()
      @transitionTo 'cart'

    removeFromCart: (lineItem)->
      lineItem.remove()
      @transitionTo 'cart'

    checkout: (order)->
      order.set 'state', 'address'
      order.save()
      @transitionTo 'order', order

