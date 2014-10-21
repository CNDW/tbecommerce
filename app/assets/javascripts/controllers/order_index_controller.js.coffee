App.OrderIndexController = Em.ObjectController.extend
  updateShipping: (->
    @get('model').save()
  ).observes('model.useShippingAddress')

  actions:
    acceptChanges: ->
      @get('model').save()