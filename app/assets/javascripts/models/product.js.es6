/* global App, DS, Em */
App.Product = DS.Model.extend({
  name: DS.attr('string'),
  description: DS.attr('string'),
  specs: DS.attr('string'),
  price: DS.attr('number'),
  featured: DS.attr('boolean'),
  productCategory: DS.attr('string'),
  productSubcategory: DS.attr('string'),
  slug: DS.attr('string'),
  displayPrice: DS.attr('string'),
  masterVariantId: DS.attr('number'),
  category: Em.computed.alias('productCategory'),
  productType: Em.computed.alias('productSubcategory'),
  tagline: DS.attr('string'),
  metaDescription: DS.attr('string'),
  metaKeywords: DS.attr('string'),
  taxonIds: DS.attr('string'),
  inCatalogue: DS.attr('boolean'),
  inCustomShop: DS.attr('boolean'),

  catalogueImage: Em.computed('images', function() {
    if (this.get('images.length') === 0) { return ''; }
    return this.get('images.firstObject.mediumUrl');
  }),

  properties: DS.hasMany('property'),
  images: DS.hasMany('image'),
  optionTypes: DS.hasMany('option-type'),
  colorTypes: DS.hasMany('color-type'),
  shippingCategory: DS.belongsTo('shipping-category'),
  productMocks: DS.hasMany('product-mock'),
  variants: DS.hasMany('variants')
});
