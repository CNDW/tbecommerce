App.CustomItem = DS.Model.extend
  isCustomItem: true
  name: Em.computed 'productId', ->
    return 'Custom Item' unless @get 'productId'
    @get 'product.name'

  inShop: DS.attr 'boolean', defaultValue: false
  inCart: Em.computed.equal 'state', 'cart'
  orderNotes: DS.attr 'string', defaultValue: null

  variantId: Em.computed.alias 'product.masterVariantId'

  state: Em.computed 'lineItem', ->
    return 'precart' if @get('lineItem') == null
    return @get('lineItem.state')

  shop_state: DS.attr 'string', defaultValue: 'new'
  shop_states: [
    'new'
    'colors'
    'options'
    'extras'
    'complete'
  ]
  shop_steps:
    'new': 0
    'colors': 1
    'options': 2
    'extras': 3
    'complete': 4

  hasProduct: Em.computed.notEmpty 'productId'
  hasColors: Em.computed 'selectedColors.@each.isSelected', ->
    selectedColors = @get 'selectedColors'
    colorLength = selectedColors.get 'length'
    if (colorLength > 0)
      selectedColors.forEach (color)->
        colorLength -= 1 if color.get('isSelected')
    return colorLength is 0

  noSelectedColors: Em.computed.empty 'selectedColors'
  colorOptions: Em.computed.alias 'product.colorTypes'

  selectedColors: DS.hasMany 'selectedColor'
  customOptions: DS.hasMany 'customOption'
  lineItem: DS.belongsTo 'lineItem', async: true

  price: DS.attr 'number'

  isComplete: Em.computed 'completedStep', ->
    @get('completedStep') > 1

  completedStep: Em.computed 'productId', 'selectedColors.@each.isSelected', ->
    step = 0
    step += 1 if @get('hasProduct')
    step += 1 if @get('hasColors')
    return step

  basePrice: Em.observer 'productId', 'customOptions.@each.selected', ->
    Em.run.scheduleOnce 'actions', this, @recalculatePrice

  productId: DS.attr 'number', defaultValue: null

  product: Em.computed 'productId', ->
    @store.findRecord('product', @get('productId')) if @get 'productId'

  product_mocks: Em.computed 'productId', ->
    @get('product.product_mocks')

  properties: Em.computed 'productId', ->
    @get 'product.properties'

  description: Em.computed 'productId', ->
    @get 'product.description'

  specs: Em.computed 'productId', ->
    @get 'product.specs'

  #-Serialization for the custom number ID
  customItem_hash: (->
    [
      @getCustomSegment()
      @getColorSegment()
      @getOptionSegment()
    ].join('e')
  ).property('productId', 'selectedColors.@each.colorValueId', 'customOptions.@each.optionValueId')

  getCustomSegment: ->
    "pvi#{@get('variantId')}"

  getColorSegment: ->
    segment = @get('selectedColors').sortBy('colorTypeId').map (selection)->
      "i#{selection.get('colorTypeId')}s#{selection.get('colorValueId')}"
    "ct#{segment.join('')}"

  getOptionSegment: ->
    segment = @get('customOptions').filterBy('selected', true).sortBy('optionValueId').map (option)->
      "i#{option.get('optionValueId')}"
    "ov#{segment.join('')}"

  removeLineItem: ->
    @set('lineItem', null)
    @save()

  #- Helper methods
  recalculatePrice: ->
    base = @get 'product.price'
    selected = @get('customOptions').filterBy 'selected', true
    selected.forEach (option)->
      base += option.get 'price'
    @set 'price', base
    @save()

  loadOptions: ->
    product = @get 'product'
    @populateColorRelationship(product)
    @populateOptionRelationship(product)

  reloadRelationships: ->
    self = this
    [@get('selectedColors'), @get('customOptions')].forEach (relationship)->
      relationship.clear()
    @save()
    @loadOptions()

  populateColorRelationship: (product)->
    self = this
    selectedColors = @get('selectedColors')
    colorTypes = product.get('colorTypes')
    colorTypes.forEach (colorType)->
      record = self.store.createRecord 'selectedColor',
        colorTypeId: colorType.get 'id'
        customItem: self
      selectedColors.addObject(record)
    @save()

  populateOptionRelationship: (product)->
    self = this
    customOptions = this.get('customOptions')
    product.get('optionTypes').forEach (optionType)->
      optionType.get('optionValues').forEach (optionValue)->
        record = self.store.createRecord 'customOption',
          optionValueId: optionValue.get 'id'
          selected: no
          customItem: self
          price: optionValue.get 'price'
          position: optionType.get('position') + optionValue.get('position')
        customOptions.addObject(record)
    @save()
