App.CustomItem = DS.Model.extend
  name: DS.attr 'string', defaultValue: 'custom item'
  inShop: DS.attr 'boolean', defaultValue: false
  noProduct: Em.computed.empty 'product'
  noSelectedColors: Em.computed.empty 'selectedColors'
  colorOptions: Em.computed.alias 'product.colorTypes'

  selectedColors: DS.hasMany 'selected_color'
  customOptions: DS.hasMany 'custom_option'

  price: (->
    @get 'product.price'
  ).property('product_id')

  product_id: DS.attr 'number'
  product: (->
    if @get('product_id')
      @store.find 'product', @get 'product_id'
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

  #- Properties for mapping SVG data
  availableColors: (->
    @store.find 'color_value'
  ).property()
  patterns: Em.computed.map 'availableColors', (color)->
    {url: color.get('small_url'), name: "#{color.get('name')}-pattern"}

  #- Helper methods
  reloadOptions: (product)->
    @unloadRelationships()
    @populateColorRelationship(product)
    @populateOptionRelationship(product)

  unloadRelationships: ->
    [@get('selectedColors.content'), @get('customOptions.content')].forEach (relationship)->
      relationship.forEach (record)->
        record.destroyRecord()

  populateColorRelationship: (product)->
    self = this
    colorTypes = product.get 'colorTypes'
    colorTypes.forEach (colorType)->
      record = self.store.createRecord 'selectedColor',
        colorType_id: colorType.get 'id'
        customItem: self
      record.save().then ->
        self.get('selectedColors').addObject(record)
    @save()

  populateOptionRelationship: (product)->
    self = this
    customOptions = this.get('customOptions')
    product.get('optionTypes').forEach (optionType)->
      optionType.get('optionValues').forEach (optionValue)->
        record = self.store.createRecord 'custom_option',
          optionValue_id: optionValue.get 'id'
          customItem: self
        record.save().then ->
          customOptions.addObject(record)
    @save()


