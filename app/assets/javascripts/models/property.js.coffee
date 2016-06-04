App.Property = DS.Model.extend
  product: DS.hasMany 'product'
  name: DS.attr 'string'
  presentation: DS.attr 'string'
  description: DS.attr 'string'
  thumbUrl: DS.attr 'string'
  mediumUrl: DS.attr 'string'
  largeUrl: DS.attr 'string'
