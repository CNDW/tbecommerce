# For more information see: http://emberjs.com/guides/routing/

Trashbags.Router.map ()->
  @route 'custom_shop', path: '/custom'
  @route 'gallery'
  @resource 'blog_entries', path: '/blog'
  @route 'about'
  @resource 'products', path: '/catalogue', ->
  	@resource 'product', path: '/:product_id'