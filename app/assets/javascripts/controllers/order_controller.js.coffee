App.OrderIndexController = Em.ObjectController.extend

  actions:
    acceptChanges: ->
      @get('model')

App.OrderPaymentController = Em.ObjectController.extend
  cards: Em.A()
  currentCard: ''

App.OrderShippingController = Em.ObjectController.extend()
