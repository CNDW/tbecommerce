# For more information see: http://emberjs.com/guides/routing/

Trashbags.Router.map ()->
  @route 'custom_shop', path: '/custom'
  @route 'gallery'
  @route 'blog'
  @route 'about'
  @resource 'products', path: '/catalogue', ->
  	@route 'product', path: '/:product_id'

