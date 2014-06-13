Trashbags.ProductSerializer = DS.RESTSerializer.extend
	extractMeta: (store, type, payload)->
		metadata = {}
		$.each payload, (key, value)->
			if (key != type.typeKey && key != type.typeKey.pluralize())
				metadata[key] = value
				delete payload[key]
		store.metaForType(type, metadata)

	extractArray: (store, primaryType, payload)->
		Em.EnumerableUtils.forEach payload, (item)->
			console.log(item.product_properties)
		@_super(store, primaryType, payload)