App.CustomItem = DS.Model.extend
  name: DS.attr 'string', {defaultValue: 'custom item'}
  noProduct: Em.computed.empty 'product'
  noSelectedColors: Em.computed.empty 'selectedColors'
  colorOptions: Em.computed.alias 'product.colorTypes'

  selectedColors: DS.hasMany 'selected_color', async: true

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


App.SelectedColor = DS.Model.extend
  name: DS.attr 'string'
  title: Em.computed.alias 'colorType.presentation'
  swatch: Em.computed.alias 'colorValue.small_url'
  selector: (->
    @get('colorType.selector')
  ).property()
  colors: Em.computed.alias 'colorType.colorValues'

  isUnselected: Em.computed.empty 'colorValue_id'

  #- Design pattern for DS.hasOne pointing to resources not saved in localStorage
  colorType_id: DS.attr 'number'
  colorType: (->
    if @get 'colorType_id'
      @store.find 'color_type', @get 'colorType_id'
  ).property('colorType_id')

  colorValue_id: DS.attr 'number'
  colorValue: (->
    if @get 'colorValue_id'
      @store.find 'color_value', @get 'colorValue_id'
  ).property('colorValue_id')

  optionValue_id: DS.attr 'number'
  optionValue: (->
    if @get 'optionValue_id'
      @store.find 'option_value', @get 'optionValue_id'
  ).property('optionValue_id')

