App.CustomItem = DS.Model.extend
  isCustomItem: true
  name: Em.computed 'product_id', ->
    return 'Custom Item' unless @get 'product_id'
    @get 'product.name'

  inShop: DS.attr 'boolean', defaultValue: false
  inCart: Em.computed.equal 'state', 'cart'
  order_notes: DS.attr 'string', defaultValue: null

  variant_id: Em.computed.alias 'product.master_variant_id'

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

  hasProduct: Em.computed.notEmpty 'product_id'
  hasColors: Em.computed 'selectedColors.@each.isSelected', ->
    selectedColors = @get 'selectedColors'
    color_length = selectedColors.get 'length'
    if (color_length > 0)
      selectedColors.forEach (color)->
        color_length -= 1 if color.get('isSelected')
    return color_length is 0

  noSelectedColors: Em.computed.empty 'selectedColors'
  colorOptions: Em.computed.alias 'product.colorTypes'

  selectedColors: DS.hasMany 'selected_color'
  customOptions: DS.hasMany 'custom_option'
  lineItem: DS.belongsTo 'line_item', async: true

  price: DS.attr 'number'

  isComplete: Em.computed 'completedStep', ->
    @get('completedStep') > 1

  completedStep: Em.computed 'product_id', 'selectedColors.@each.isSelected', ->
    step = 0
    step += 1 if @get('hasProduct')
    step += 1 if @get('hasColors')
    return step

  basePrice: Em.observer 'product_id', 'customOptions.@each.selected', ->
    Em.run.scheduleOnce 'actions', this, @recalculatePrice

  product_id: DS.attr 'number', defaultValue: null

  product: Em.computed 'product_id', ->
    @store.getById('product', @get('product_id')) if @get 'product_id'

  product_mocks: Em.computed 'product_id', ->
    @get('product.product_mocks')

  properties: Em.computed 'product_id', ->
    @get 'product.properties'

  description: Em.computed 'product_id', ->
    @get 'product.description'

  specs: Em.computed 'product_id', ->
    @get 'product.specs'

  #-Serialization for the custom number ID
  custom_item_hash: (->
    [
      @getCustomSegment()
      @getColorSegment()
      @getOptionSegment()
    ].join('e')
  ).property('product_id', 'selectedColors.@each.colorValue_id', 'customOptions.@each.optionValue_id')

  getCustomSegment: ->
    "pvi#{@get('variant_id')}"

  getColorSegment: ->
    segment = @get('selectedColors').sortBy('colorType_id').map (selection)->
      "i#{selection.get('colorType_id')}s#{selection.get('colorValue_id')}"
    "ct#{segment.join('')}"

  getOptionSegment: ->
    segment = @get('customOptions').filterBy('selected', true).sortBy('optionValue_id').map (option)->
      "i#{option.get('optionValue_id')}"
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
      record = self.store.createRecord 'selected_color',
        colorType_id: colorType.get 'id'
        customItem: self
      selectedColors.addObject(record)
    @save()

  populateOptionRelationship: (product)->
    self = this
    customOptions = this.get('customOptions')
    product.get('optionTypes').forEach (optionType)->
      optionType.get('optionValues').forEach (optionValue)->
        record = self.store.createRecord 'custom_option',
          optionValue_id: optionValue.get 'id'
          selected: no
          customItem: self
          price: optionValue.get 'price'
          position: optionType.get('position') + optionValue.get('position')
        customOptions.addObject(record)
    @save()
