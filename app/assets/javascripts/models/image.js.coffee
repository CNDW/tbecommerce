App.Image = DS.Model.extend
  position: DS.attr 'number'
  alt: DS.attr 'string'
  thumb_url: DS.attr 'string'
  small_url: DS.attr 'string'
  medium_url: DS.attr 'string'
  large_url: DS.attr 'string'

  product: DS.belongsTo 'product'
  variant: DS.belongsTo 'variant'
