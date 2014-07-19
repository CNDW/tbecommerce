Trashbags.Product = DS.Model.extend
  name: DS.attr 'string'
  description: DS.attr 'string'
  price: DS.attr 'number'
  product_category: DS.attr 'string'
  product_subcategory: DS.attr 'string'
  slug: DS.attr 'string'
  displayPrice: DS.attr 'string'
  category: Em.computed.alias 'product_category'
  type: Em.computed.alias 'product_subcategory'

  productProperties: DS.hasMany 'product_property', async: true
  images: DS.hasMany 'images', async: true