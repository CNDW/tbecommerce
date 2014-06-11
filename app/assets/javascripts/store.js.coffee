# http://emberjs.com/guides/models/#toc_store
# http://emberjs.com/guides/models/pushing-records-into-the-store/

Trashbags.ApplicationStore = DS.Store.extend({

})

Trashbags.ApplicationAdapter = DS.RESTAdapter.extend
	namespace: 'api'