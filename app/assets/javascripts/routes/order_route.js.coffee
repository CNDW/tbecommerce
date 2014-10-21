App.OrderRoute = Em.Route.extend()

App.OrderIndexRoute = Em.Route.extend

  deactivate: ->
    @modelFor('order.index').updateAddresses()

  actions:
    orderCreate: (order)->
      # order.createOrder()



App.OrderPaymentRoute = Em.Route.extend

  afterModel: (model, transition)->
    unless model.get('created')
      @transitionTo 'order.index', model
