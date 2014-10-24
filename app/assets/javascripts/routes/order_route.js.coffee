App.OrderRoute = Em.Route.extend()

App.OrderIndexRoute = Em.Route.extend

  deactivate: ->
    order = @modelFor('order.index')
    order.updateAddresses() if order.get('isDirty')

  actions:
    completeCheckoutAddresses: ->
      self = this
      order = @modelFor('order.index')
      order.updateAddresses(yes).done ->
        if order.get('checkoutCompleted') < 1
          order.completeAddresses().done ->
            self.transitionTo 'order.payment'

App.OrderPaymentRoute = Em.Route.extend

  afterModel: (model, transition)->
    unless model.get('created')
      @transitionTo 'order.index', model
