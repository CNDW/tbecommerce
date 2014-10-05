App.Property = DS.Model.extend
  product: DS.hasMany 'product'
  name: DS.attr 'string'
  presentation: DS.attr 'string'
  description: DS.attr 'string'
  thumb_url: DS.attr 'string'
  medium_url: DS.attr 'string'
  large_url: DS.attr 'string'