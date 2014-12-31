App.CompletedOrderMixin = Em.Mixin.create
  completedReroute: (order)->
    if order.get('checkoutStep') > 3
      this.transitionTo 'order.completed', order

App.OrderRoute = Em.Route.extend

  actions:
    error: ->
      @transitionTo 'cart'
    removeFromCart: (lineItem)->
      self = this
      order = @modelFor('order')
      order.removeLineItem(lineItem).then ->
        self.refresh()

App.OrderIndexRoute = Em.Route.extend App.CompletedOrderMixin,

  afterModel: (model)->
    @completedReroute(model)
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

App.OrderShippingRoute = Em.Route.extend App.CompletedOrderMixin,

  afterModel: (model, transition)->
    @completedReroute(model)
    unless model.get('checkoutStep') > 1
      @transitionTo 'order.index', model

  actions:
    completeCheckoutShipping: ->
      self = this
      order = @modelFor('order.shipping')
      order.updateShipments('alert_error').then ->
        order.advanceState('payment').then ->
          self.transitionTo 'order.payment'

App.OrderPaymentRoute = Em.Route.extend App.CompletedOrderMixin,

  afterModel: (model, transition)->
    @completedReroute(model)
    unless model.get('checkoutStep') > 2
      @transitionTo 'order.shipping', model

  setupController: (controller, model)->
    @store.find('card').then (data)=>
      controller.set 'model', model
      unused_cards = data.filterBy('used', false)
      controller.set 'cards', unused_cards
      # if Em.empty(unused_cards)
      card = @store.createRecord 'card'
      controller.set 'currentCard', card
      # else
      #   controller.set 'currentCard', unused_cards.get('firstObject')

  actions:
    submitOrder: (card, order)->
      self = this
      card.createToken(order).then ->
        order.createPayment(order.get('payment_methods').findBy('method_type', 'stripe'), card).then ->
          order.completePayment().then ->
            card.set 'used', true
            # card.save()
            self.transitionTo 'order.completed', order

App.OrderCompletedRoute = Em.Route.extend

  afterModel: (model, transition)->
    unless model.get('checkoutStep') > 3
      @transitionTo 'order.payment', model
    cart = @modelFor('application')
    cart.resetCart()

