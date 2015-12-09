App.CustomFeaturesController = Em.Controller.extend
  options: Em.computed.sort 'model.customOptions', (a, b)->
    a.get('position') - b.get('position')

  price: Em.computed.alias 'model.price'

  saveModel: ->
    @get('model').save()

  actions:
    clickOption: (option)->
      option.toggleProperty('selected')
      return false
