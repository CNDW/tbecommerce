App.OrderRoute = Em.Route.extend

  actions:
    removeFromCart: (lineItem)->
      self = this
      order = @modelFor('order')
      order.removeLineItem(lineItem).then ->
        self.refresh()

App.OrderIndexRoute = Em.Route.extend

  deactivate: ->
    order = @modelFor('order.index')
    order.updateAddresses() if order.get('isDirty')

  actions:
    completeCheckoutAddresses: ->
      self = this
      order = @modelFor('order.index')
      order.updateAddresses(yes).then (responseJSON)->
        order.updateShipments(responseJSON.shipments)
        order.advanceState(2).then ->
          self.transitionTo 'order.payment'

App.OrderShippingRoute = Em.Route.extend

  afterModel: (model, transition)->
    unless model.get('checkoutCompleted') > 1
      @transitionTo 'order.index', model

  actions:
    completeCheckoutShipping: ->
      self = this
      order = @modelFor('order.index')
      order.updateAddresses(yes).then ->
        order.advanceState(3).then ->
          self.transitionTo 'order.payment'

App.OrderPaymentRoute = Em.Route.extend

  afterModel: (model, transition)->
    unless model.get('checkoutCompleted') > 2
      @transitionTo 'order.shipping', model

  actions:
    completeCheckoutPayment: ->
      self = this
      order = @modelFor('order.index')
      order.updateAddresses(yes).then ->
        order.advanceState(4).then ->
          self.transitionTo 'order.payment'
