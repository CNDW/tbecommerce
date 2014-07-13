Trashbags.Image = DS.Model.extend
  position: DS.attr 'number'
  attachment_content_type: DS.attr 'string'
  attachment_file_name: DS.attr 'string'
  attachment_width: DS.attr 'number'
  atttachment_height: DS.attr 'number'
  alt: DS.attr 'string'
  mini_url: DS.attr 'string'
  small_url: DS.attr 'string'
  product_url: DS.attr 'string'
  large_url: DS.attr 'string'
  carousel_large_url: DS.attr 'string'
  carousel_medium_url: DS.attr 'string'
  carousel_small_url: DS.attr 'string'
  product_type: Em.computed 'product', ->
    @get('product.type')
  product: DS.belongsTo 'product', async: true
