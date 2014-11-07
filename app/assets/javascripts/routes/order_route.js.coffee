App.OrderRoute = Em.Route.extend

  actions:
    error: ->
      @transitionTo 'cart'
    removeFromCart: (lineItem)->
      self = this
      order = @modelFor('order')
      order.removeLineItem(lineItem).then ->
        self.refresh()

App.OrderIndexRoute = Em.Route.extend

  afterModel: (model)->
    if model.get('ship_address') == null
      model.set 'ship_address', @store.createRecord('ship_address')
      model.set 'bill_address', @store.createRecord('bill_address')

  deactivate: ->
    order = @modelFor('order.index')
    order.updateAddresses() if order.get('isDirty')

  actions:
    completeCheckoutAddresses: ->
      self = this
      order = @modelFor('order.index')
      order.updateAddresses('alert_error').then (responseJSON)->
        order.advanceState('delivery').then ->
          self.transitionTo 'order.shipping'

App.OrderShippingRoute = Em.Route.extend

  afterModel: (model, transition)->
    unless model.get('checkoutStep') > 1
      @transitionTo 'order.index', model

  actions:
    completeCheckoutShipping: ->
      self = this
      order = @modelFor('order.shipping')
      order.updateShipments('alert_error').then ->
        order.advanceState('payment').then ->
          self.transitionTo 'order.payment'

App.OrderPaymentRoute = Em.Route.extend

  afterModel: (model, transition)->
    unless model.get('checkoutStep') > 2
      @transitionTo 'order.shipping', model

  setupController: (controller, model)->
    @store.find('card').then (data)=>
      controller.set 'model', model
      controller.set 'cards', data
      if Em.empty(data)
        card = @store.createRecord 'card'
        controller.set 'currentCard', card
      else
        controller.set 'currentCard', data.get('firstObject')

  actions:
    submitOrder: (card, order)->
      card.createToken(order).then ->
        order.createPayment(order.get('payment_methods.firstObject.id'), card).then ->
          debugger

