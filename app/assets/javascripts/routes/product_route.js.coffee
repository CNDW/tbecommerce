App.ProductRoute = Em.Route.extend
	model: (params)->
		@store.find 'product', params.product_id