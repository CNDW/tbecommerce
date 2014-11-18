App.Router = Ember.Router.extend()

App.Router.map ->
  @route 'application'
  @route 'blog'
  @route 'gallery'
  @route 'about'
  @resource 'catalogue', ->
    @resource 'catalogue.bags', path: '/bags'
    @resource 'catalogue.apparel', path: '/apparel'
    @resource 'catalogue.utility', path: '/utility'
  @route 'bag'
  @route 'custom_shop'
  @resource 'custom', path: '/custom/:custom_item_id', ->
    @route 'product', path: '/item'
    @route 'colors'
    @route 'features'
    @route 'extras'
  @route 'instock'
  @route 'instockitem'
  @route 'cart'
  @resource 'product', path: '/product/:product_id'
  @resource 'order', path: '/order/:order_id', ->
    @route 'shipping'
    @route 'payment'
    @route 'completed'