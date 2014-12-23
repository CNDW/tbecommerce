App.Product = DS.Model.extend
  name: DS.attr 'string'
  description: DS.attr 'string'
  specs: DS.attr 'string'
  price: DS.attr 'number'
  featured: DS.attr 'boolean'
  product_category: DS.attr 'string'
  product_subcategory: DS.attr 'string'
  slug: DS.attr 'string'
  displayPrice: DS.attr 'string'
  master_variant_id: DS.attr 'number'
  category: (->
    @get 'product_category'
  ).property()
  product_type: (->
    @get 'product_subcategory'
  ).property()
  tagline: DS.attr 'string'
  meta_description: DS.attr 'string'
  meta_keywords: DS.attr 'string'
  taxon_ids: DS.attr 'string'
  in_catalogue: DS.attr 'boolean'
  in_custom_shop: DS.attr 'boolean'

  catalogue_image: Em.computed 'images', ->
    return '' if @get('images.length') is 0
    return @get 'images.firstObject.medium_url'

  properties: DS.hasMany 'property'
  images: DS.hasMany 'image'
  optionTypes: DS.hasMany 'option_type'
  colorTypes: DS.hasMany 'color_type'
  shippingCategory: DS.belongsTo 'shipping_category'
  product_mocks: DS.hasMany 'product_mock'