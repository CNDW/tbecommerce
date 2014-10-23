App.LineItem = DS.Model.extend
  product: DS.belongsTo 'product'
  customItem: DS.belongsTo 'custom_item'
  order: DS.belongsTo 'order'
  variant_id: Em.computed.alias 'customItem.variant_id'
  line_item_id: DS.attr 'number'
  isDirty: DS.attr 'boolean', defaultValue: true
  custom_item_hash: Em.computed.alias 'customItem.custom_item_hash'
  state: (->
    return 'precart' if @get('order') is null
    @get('order.state')
  ).property('order')
  inOrder: (->
    @get('order') != null
  ).property('order')

  inCart: (->
    !@get('inOrder') and @get('isComplete')
  ).property('inOrder', 'isComplete')

  name: Em.computed.alias 'customItem.name'
  price: Em.computed.alias 'customItem.price'
  isComplete: Em.computed.alias 'customItem.isComplete'

  remove: ->
    @get('customItem').removeLineItem()
    @set('order', null)
    @destroyRecord()