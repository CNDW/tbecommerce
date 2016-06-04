App.Image = DS.Model.extend
  position: DS.attr 'number'
  alt: DS.attr 'string'
  thumbUrl: DS.attr 'string'
  smallUrl: DS.attr 'string'
  mediumUrl: DS.attr 'string'
  largeUrl: DS.attr 'string'

  product: DS.belongsTo 'product'
  variant: DS.belongsTo 'variant'
