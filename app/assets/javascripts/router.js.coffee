App.Router = Ember.Router.extend()

App.Router.map ->
  @route 'application'
  @route 'blog'
  @route 'gallery'
  @route 'about'
  @resource 'catalogue', ->
    @route 'index', path: '/bags'
  @route 'bag'
  @resource 'custom', ->
    @resource 'custom.index', path: '/item', ->
      @route 'index'
      @route 'item'
    @route 'features'
    @route 'extras'
    @route 'colors'
  @route 'instock'
  @route 'instockitem'
  @route 'cart'