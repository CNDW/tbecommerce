App.LineItem = DS.Model.extend
  quantity: DS.attr 'number'
  price: DS.attr 'string'
  singleDisplayAmmount: DS.attr 'string'
  total: DS.attr 'string'
  displayTotal: DS.attr 'string'

  customItem: DS.belongsTo 'customItem', async: true
  order: DS.belongsTo 'order'
  customItemHash: DS.attr 'string'
  variant: DS.belongsTo 'variant'
  orderNotes: DS.attr 'string'

  variantId: Em.computed ->
    return @get('variant.id') if @get('variant')
    @get('customItem.variantId')

  isCustom: Em.computed.alias 'variant.isMaster'

  didLoad: ->
    @get('variant').set('totalInCart', @get('quantity')) if @get('variant')

  orderIsComplete: Em.computed.alias 'order.isComplete'

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

  name: Em.computed 'customItem.name', 'variant.name', 'variant.instockDescription', ->
    return "Custom #{@get('customItem.name')}" if @get('customItem.name')
    "#{@get('variant.name')}, #{@get('variant.instockDescription')}"

  remove: ->
    @get('customItem').removeLineItem()
    @set('order', null)
    @destroyRecord()
