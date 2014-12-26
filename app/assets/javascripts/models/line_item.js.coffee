App.LineItem = DS.Model.extend
  quantity: DS.attr 'number'
  price: DS.attr 'string'
  single_display_ammount: DS.attr 'string'
  total: DS.attr 'string'
  display_total: DS.attr 'string'

  customItem: DS.belongsTo 'custom_item', async: true
  order: DS.belongsTo 'order'
  custom_item_hash: DS.attr 'string'
  variant: DS.belongsTo 'variant'

  is_custom: Em.computed.alias 'variant.is_master'

  didCreate: ->
    console.log 'lineItem.didCreate'

  order_isComplete: Em.computed.alias 'order.isComplete'

  # state: (->
  #   return 'precart' if @get('order') is null
  #   @get('order.state')
  # ).property('order')

  # inOrder: (->
  #   @get('order') != null
  # ).property('order')

  # inCart: (->
  #   !@get('inOrder') and @get('isComplete')
  # ).property('inOrder', 'isComplete')

  name: Em.computed.alias 'customItem.name'

  remove: ->
    @get('customItem').removeLineItem()
    @set('order', null)
    @destroyRecord()