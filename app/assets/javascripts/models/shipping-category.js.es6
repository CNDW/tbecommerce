App.ShippingCategory = DS.Model.extend({
  shippingMethods: DS.hasMany('shipping-method'),
  products: DS.hasMany('product'),
  name: DS.attr('string')
});

App.ShippingMethod = DS.Model.extend({
  shippingCategory: DS.hasMany('shipping-category'),
  name: DS.attr('string'),
  tagline: DS.attr('string'),
  taxCategoryId: DS.attr('string')
});
