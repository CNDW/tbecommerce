App.LineItem = DS.Model.extend
  product: DS.belongsTo 'product'
  customItem: DS.belongsTo 'custom_item'
  order: DS.belongsTo 'order'

  name: Em.computed.alias 'customItem.name'
  price: Em.computed.alias 'customItem.price'
  isComplete: Em.computed.alias 'customItem.isComplete'

  remove: ->
    customItem = @get('customItem')
    customItem.set('lineItem', null)
    customItem.set('inCart', no)
    customItem.save()
    @destroyRecord()