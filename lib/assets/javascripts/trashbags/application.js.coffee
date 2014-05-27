#= require jquery
#= require handlebars
#= require ember
#= require ember-data
#= require_self
#= require ./trashbags

# for more details see: http://emberjs.com/guides/application/
window.Trashbags = Ember.Application.create(
  LOG_ACTIVE_GENERATION: true
  LOG_MODULE_RESOLVER: true
  LOG_TRANSITIONS: true
  LOG_TRANSITIONS_INTERNAL: true
  LOG_VIEW_LOOKUPS: true
  )

Ember.RSVP.configure('onerror', (error)->
	console.log(error.message)
	console.log(error.stack)
	if (error instanceof Error)
		Ember.Logger.assert(false, error)
		Ember.Logger.error(error.stack)
)