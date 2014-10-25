App.ShippingCategory = DS.Model.extend
  shippingMethods: DS.hasMany 'shipping_method'
  products: DS.hasMany 'product'
  name: DS.attr 'string'

App.ShippingMethod = DS.Model.extend
  shippingCategory: DS.hasMany 'shipping_category'
  name: DS.attr 'string'