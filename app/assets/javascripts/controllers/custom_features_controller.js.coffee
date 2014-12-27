App.CustomFeaturesController = Em.ObjectController.extend
  options: Em.computed.sort 'model.customOptions', (a, b)->
    a.get('position') - b.get('position')

  saveModel: ->
    @get('model').save()

  actions:
    clickOption: (option)->
      option.toggleProperty('selected')
      return false
