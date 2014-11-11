App.ProductMock = DS.Model.extend
  name: DS.attr 'string'
  position: DS.attr 'number'
  svg_url: DS.attr 'string'
  product: DS.belongsTo 'product'
