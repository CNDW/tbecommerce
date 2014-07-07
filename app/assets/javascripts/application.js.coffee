#= require jquery
#= require bootstrap
#= require handlebars
#= require ember
#= require ember-data
#= require pongstagr.am
#= require_self
#= require ./store
#= require_tree ./models
#= require_tree ./controllers
#= require_tree ./views
#= require_tree ./helpers
#= require_tree ./components
#= require_tree ./templates
#= require_tree ./routes
#= require_tree ./serializers
#= require ./router

# for more details see: http://emberjs.com/guides/application/
window.Trashbags = Ember.Application.create(
  LOG_ACTIVE_GENERATION: true
  LOG_MODULE_RESOLVER: true
  LOG_TRANSITIONS: true
  LOG_TRANSITIONS_INTERNAL: true
  LOG_VIEW_LOOKUPS: true
  )

Ember.RSVP.configure('onerror', (error)->
	if (error instanceof Error)
		Ember.Logger.assert(false, error)
		Ember.Logger.error(error.stack)
)