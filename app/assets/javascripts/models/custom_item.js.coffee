DS.RawTransform = DS.Transform.extend
  deserialize: (serialized)->
    serialized
  serialze: (deserialized)->
    deserialized

App.CustomItem = DS.Model.extend
  name: DS.attr 'string', {defaultValue: 'custom item'}
  noProduct: Em.computed.empty 'product'

  completedSteps: (->
    first = !@get('noProduct')
    second = false
    third = true
    steps = [first, second, third]
  ).property('noProduct')

  stepIndex: (->
    index = 0
    @get('completedSteps').every (completed, step)->
      if (completed)
        index = step + 1
        return false
    return index
  ).property('completedSteps')

  product: DS.belongsTo 'product'
  colors: DS.attr 'raw'

App.CustomItemAdapter = DS.LSAdapter.extend()
App.CustomItemSerializer = DS.LSSerializer.extend()
