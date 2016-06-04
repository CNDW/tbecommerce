App.CustomController = Em.Controller.extend({
  store: Em.inject.service('store'),
  product: Em.computed.alias('model.product'),
  hasProduct: Em.computed.alias('model.hasProduct'),

  hasColors: Em.computed.alias('model.hasColors'),

  hasProductAndColors: Em.computed.and('hasProduct', 'hasColors'),

  price: Em.computed.alias('model.price'),

  products: Em.computed(function() {
    return this.get('store').peekAll('product').filter((product) => {
      product.get('inCustomShop');
    });
  }),

  featuredItems: Em.computed('products', function() {
    return this.get('products').filterBy('featured', true);
  }),

  mocks: Em.computed.alias('model.productMocks'),

  mockIndex: 0,

  activeMock: Em.computed('mocks', 'mockIndex', function() {
    return this.get('mocks').objectAt(this.get('mockIndex'));
  })
});
