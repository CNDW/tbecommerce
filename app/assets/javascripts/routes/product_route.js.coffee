App.ProductRoute = Em.Route.extend
	model: (params)->
		@store.peekAll 'product', params.product_id
