App.ApplicationRoute = Em.Route.extend
  model: ->
    @store.find 'product'

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

