Trashbags.ProductsController = Em.ArrayController.extend
	bagTypes: (->
		products = @get('content').filterBy('product_category', 'bag').sortBy('price')
		types = products.mapBy('type').uniq().map (item, index, object)->
			val = {}
			val.name = item.capitalize()
			val.products = products.filterBy('type', item)
			return val
		).property('productsByCategory')
	apparelTypes: (->
		products = @get('content').filterBy('product_category', 'apparel').sortBy('price')
		types = products.mapBy('type').uniq().map (item, index, object)->
			val = {}
			val.name = item.capitalize()
			val.products = products.filterBy('type', item)
			return val
		).property('productsByCategory')
	utilityTypes: (->
		products = @get('content').filterBy('product_category', 'utility').sortBy('price')
		types = products.mapBy('type').uniq().map (item, index, object)->
			val = {}
			val.name = item.capitalize()
			val.products = products.filterBy('type', item)
			return val
		).property('productsByCategory')