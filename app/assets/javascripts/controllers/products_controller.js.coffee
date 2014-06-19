Trashbags.ProductsController = Em.ArrayController.extend
	categories: (->
		@get('content').mapBy('product_category').uniq()
		).property()
	productsByCategory: (->
		content = @get('content')
		@get('categories').map( (item, index, enumerable)->
			content.filterBy('product_category', item)
			)
		).property('categories')