# http://emberjs.com/guides/models/#toc_store
# http://emberjs.com/guides/models/pushing-records-into-the-store/

Trashbags.Store = DS.Store.extend({

})

Trashbags.ApplicationAdapter = DS.RESTAdapter.extend
	namespace: 'api'

Trashbags.ApplicationSerializer = DS.RESTSerializer.extend
	extractMeta: (store, type, payload)->
		metadata = {}
		$.each payload, (key, value)->
			if (key != type.typeKey && key != type.typeKey.pluralize())
				metadata[key] = value
				delete payload[key]
		store.metaForType(type, metadata)
