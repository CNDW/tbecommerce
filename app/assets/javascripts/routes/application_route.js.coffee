Trashbags.ApplicationRoute = Em.Route.extend
	model: ->
		@store.find('product')

	actions:
		openModal: ()->
			console.log('openModal fire')
			#@controllerFor(modalName).set('model', model)
			@render("features", 
				outlet: 'modal'
				into: 'application'
				)
		closeModal: ->
			@disconnectOutlet
				outlet: 'modal'
				parentView: 'product'