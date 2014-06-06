Trashbags.DetailThumbnailComponent = Em.Component.extend
	classNames: "col-detail-thumb"
	layout: Ember.Handlebars.compile "<div class='thumbnail'>{{yield}}</div>"
	click: ->
		@sendAction()