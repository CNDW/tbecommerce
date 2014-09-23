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
  @route 'custom'
  @route 'instock'
  @route 'instockitem'
  @route 'cart'
  @resource 'product', path: '/product/:product_id'