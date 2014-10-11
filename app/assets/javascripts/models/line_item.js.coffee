App.LineItem = DS.Model.extend
  product: DS.belongsTo 'product'
  customItem: DS.belongsTo 'custom_item'
