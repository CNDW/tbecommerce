App.CustomItem = DS.Model.extend
  name: DS.attr 'string', defaultValue: 'custom item'
  inShop: DS.attr 'boolean', defaultValue: false
  inCart: Em.computed.equal 'state', 'cart'

  variant_id: Em.computed.alias 'product.master_variant_id'

  state: (->
    return 'precart' if @get('lineItem') == null
    return @get('lineItem.state')
  ).property('lineItem')
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
  noSelectedColors: Em.computed.empty 'selectedColors'
  colorOptions: Em.computed.alias 'product.colorTypes'

  selectedColors: DS.hasMany 'selected_color'
  customOptions: DS.hasMany 'custom_option'
  lineItem: DS.belongsTo 'line_item'

  price: DS.attr 'number'

  isComplete: (->
    @get('completedStep') > 1
  ).property('completedStep')

  completedStep: (->
    step = 0
    step += 1 if @get('hasProduct')
    selectedColors = @get 'selectedColors'
    color_length = selectedColors.get 'length'
    if (color_length > 0)
      selectedColors.forEach (color)->
        color_length -= 1 if color.get('isSelected')
      step += 1 if color_length is 0
    return step
  ).property('product_id', 'selectedColors.@each.isSelected')

  basePrice: (->
    @recalculatePrice()
  ).observes('product_id').on('init')

  product_id: DS.attr 'number', defaultValue: null
  product: (->
    @store.getById('product', @get('product_id')) if @get 'product_id'
  ).property('product_id')
  product_mocks: (->
    @get('product.product_mocks')
  ).property('product_id')

  properties: (->
    @get 'product.properties'
  ).property('product_id')

  description: (->
    @get 'product.description'
  ).property('product_id')

  specs: (->
    @get 'product.specs'
  ).property('product_id')

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
    segment = @get('selectedColors').map (selection)->
      "i#{selection.get('colorType_id')}s#{selection.get('colorValue_id')}"
    "ct#{segment.join('')}"

  getOptionSegment: ->
    segment = @get('customOptions').map (option)->
      "i#{option.get('optionValue_id')}"
    "ov#{segment.join('')}"

  #- Properties for mapping SVG data
  availableColors: (->
    @store.all 'color_value'
  ).property()
  patterns: Em.computed.map 'availableColors', (color)->
    "<pattern id='#{color.get('name')}-pattern' patternUnits='userSpaceOnUse' style='overflow:visible;' width='200px' height='200px'> <image xlink:href=#{color.get('small_url')} x='0' y='0' width='200px' height='200px' /> </pattern>"

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

  loadOptions: ()->
    product = @get 'product'
    @populateColorRelationship(product)
    @populateOptionRelationship(product)

  reloadRelationships: ->
    console.log('reloadRelationships')
    self = this
    [@get('selectedColors'), @get('customOptions')].forEach (relationship)->
      items = relationship.content.toArray()
      items.forEach (record)->
        relationship.removeRecord(record)
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
      selectedColors.addRecord(record)
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
        customOptions.addRecord(record)
    @save()
