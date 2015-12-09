App.OrderIndexController = Em.Controller.extend

  actions:
    acceptChanges: ->
      @get('model')

App.OrderPaymentController = Em.Controller.extend
  cards: Em.A()
  currentCard: ''

App.OrderShippingController = Em.Controller.extend()
