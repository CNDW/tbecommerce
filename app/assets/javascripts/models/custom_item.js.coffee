App.CustomItem = DS.Model.extend
  name: DS.attr 'string', {defaultValue: 'custom item'}
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
