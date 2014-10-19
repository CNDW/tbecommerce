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
        @transitionTo 'cart'
        return
      product = item.get 'product'
      record = @store.createRecord 'line_item',
        product: product,
        customItem: item
      record.save()
      item.set 'inCart', true
      item.set 'inShop', false
      item.save()
      @transitionTo 'cart'

    removeFromCart: (lineItem)->
      lineItem.remove()
      @transitionTo 'cart'

