App.Router = Ember.Router.extend();

App.Router.map(function() {
  this.route('gallery');
  this.route('about');
  this.route('catalogue', function() {
    this.route('bags');
    this.route('apparel');
    this.route('utility');
  });
  this.route('bag');
  this.route('custom-shop');
  this.route('custom', {path: '/custom/:custom_item_id'}, function() {
    this.route('product', {path: '/item'});
    this.route('colors');
    this.route('features');
  });
  this.route('instock', function() {
    this.route('index', {path: '/'});
    this.route('item', {path: ':variant_id'});
  });
  this.route('cart');
  this.route('product', {path: '/product/:product_id'});
  this.route('order', {path: '/order/:order_id'}, function() {
    this.route('shipping');
    this.route('payment');
    this.route('completed');
  });
});
