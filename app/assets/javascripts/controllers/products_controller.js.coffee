Trashbags.ProductsController = Em.ArrayController.extend
	categories: (->
		@get('content').mapBy('product_category').uniq()
		).property()
	sortedProducts: (->
		sorted = {}
		@get('content').mapBy('product_category').uniq().forEach (obj, callback, collection)->
			sorted[obj] = {}
		@get('content').forEach (obj, callback, collection)->
			cat = obj.get('category')
			typ = obj.get('type')
			if (sorted[cat].hasOwnProperty(typ))
				sorted[cat][typ].push obj
			else
				sorted[cat][typ] = [obj]
		return sorted
		).property()
	productsByCategory: (->
		bags = @get('content').filterBy('product_category', 'bag')
		apparel = @get('content').filterBy('product_category', 'apparel')
		utility = @get('content').filterBy('product_category', 'utility')
		return [bags, apparel, utility]
		).property('categories')
	bagTypes: (->
		products = @get('productsByCategory')[0]
		types = products.mapBy('type').uniq().map (item, index, object)->
			val = {}
			val.name = item
			val.products = products.filterBy('type', item)
			return val
		).property('productsByCategory')
	apparelTypes: (->
		products = @get('productsByCategory')[1]
		types = products.mapBy('type').uniq().map (item, index, object)->
			val = {}
			val.name = item
			val.products = products.filterBy('type', item)
			return val
		).property('productsByCategory')
	utilityTypes: (->
		products = @get('productsByCategory')[2]
		types = products.mapBy('type').uniq().map (item, index, object)->
			val = {}
			val.name = item
			val.products = products.filterBy('type', item)
			return val
		).property('productsByCategory')