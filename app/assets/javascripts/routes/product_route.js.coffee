Trashbags.ProductRoute = Em.Route.extend
	model: (params)->
		@store.find('product', params.product_id)
	renderTemplate: ->
		@render('products/stats', {
			outlet: 'productStats'
			into: 'products'
			})
		@render('product',
			into: 'products'
			)
