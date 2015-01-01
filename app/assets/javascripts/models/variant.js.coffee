App.Variant = DS.Model.extend
  isVariant: yes
  name: DS.attr 'string'
  sku: DS.attr 'string'
  price: DS.attr 'string'
  weight: DS.attr 'string'
  height: DS.attr 'string'
  width: DS.attr 'string'
  depth: DS.attr 'string'
  is_master: DS.attr 'boolean'
  slug: DS.attr 'string'
  description: DS.attr 'string'
  track_inventory: DS.attr 'boolean'
  instock_description: DS.attr 'string'
  display_price: DS.attr 'string'
  total_on_hand: DS.attr 'number'
  options_text: DS.attr 'string'
  total_in_cart: DS.attr 'number', defaultValue: 0

  total_not_in_cart: Em.computed 'total_in_cart', 'total_on_hand', ->
    @get('total_on_hand') - @get('total_in_cart')
  isUnavailable: Em.computed.lt 'total_not_in_cart', 1

  images: DS.hasMany 'image'
  option_values: DS.hasMany 'option_value'
  product: DS.belongsTo 'product'
  variant_colors: DS.attr 'array'

  catalogue_image: Em.computed 'images', ->
    return '' if @get('images.length') is 0
    return @get('images.firstObject.medium_url')

  type: Em.computed.alias 'product.product_type'
  category: Em.computed.alias 'product.product_category'
  product_name: Em.computed.alias 'product.name'

  variant_id: Em.computed.alias 'id'

  total_price: Em.computed ()->
    base = Number(@get 'price')
    @get('option_values').forEach (val)->
      base = base + Number(val.get 'price')
    return base

  display_total_price: Em.computed ()->
    '$' + @get('total_price')

  custom_item_hash: (->
    [
      @getCustomSegment()
      @getColorSegment()
      @getOptionSegment()
    ].join('e')
  ).property('product_id', 'variant_colors@each.colorValue_id', 'option_values.@each.optionValue_id')

  getCustomSegment: ->
    "pvi#{@get('variant_id')}"

  getColorSegment: ->
    segment = @get('variant_colors').sortBy('color_type_id').map (selection)->
      "i#{selection.color_type_id}s#{selection.color_value_id}"
    "ct#{segment.join('')}"

  getOptionSegment: ->
    segment = @get('option_values').sortBy('id').map (option)->
      "i#{option.get('id')}"
    "ov#{segment.join('')}"
