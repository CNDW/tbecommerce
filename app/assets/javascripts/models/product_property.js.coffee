App.ProductProperty = DS.Model.extend
  product: DS.belongsTo('product')
  value: DS.attr('string')
  property_name: DS.attr('string')
  description: DS.attr('string')
  thumb_url: DS.attr('string')
  medium_url: DS.attr('string')
  large_url: DS.attr('string')