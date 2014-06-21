Trashbags.ProductsController = Em.ArrayController.extend
	categories: (->
		@get('content').mapBy('product_category').uniq()
		).property()
	productsByCategory: (->
		bags = @get('content').filterBy('product_category', 'bag')
		apparel = @get('content').filterBy('product_category', 'apparel')
		utility = @get('content').filterBy('product_category', 'utility')
		return [bags, apparel, utility]
		).property('categories')
	bagTypes: (->
		products = @get('productsByCategory')[0].sortBy('price')
		types = products.mapBy('type').uniq().map (item, index, object)->
			val = {}
			val.name = item.capitalize()
			val.products = products.filterBy('type', item)
			return val
		).property('productsByCategory')
	apparelTypes: (->
		products = @get('productsByCategory')[1].sortBy('price')
		types = products.mapBy('type').uniq().map (item, index, object)->
			val = {}
			val.name = item.capitalize()
			val.products = products.filterBy('type', item)
			return val
		).property('productsByCategory')
	utilityTypes: (->
		products = @get('productsByCategory')[2].sortBy('price')
		types = products.mapBy('type').uniq().map (item, index, object)->
			val = {}
			val.name = item.capitalize()
			val.products = products.filterBy('type', item)
			return val
		).property('productsByCategory')