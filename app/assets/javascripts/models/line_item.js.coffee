App.LineItem = DS.Model.extend
  product: DS.belongsTo 'product'
  customItem: DS.belongsTo 'custom_item'
  name: Em.computed.alias 'customItem.name'
  price: Em.computed.alias 'customItem.price'

  remove: ->
    customItem = @get('customItem')
    customItem.set('lineItem', null)
    customItem.set('inCart', no)
    customItem.save()
    @destroyRecord()