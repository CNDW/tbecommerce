App.OrderIndexController = Em.ObjectController.extend

  actions:
    acceptChanges: ->
      @get('model')