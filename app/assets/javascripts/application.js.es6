//= require jquery
//= require handlebars
//= require ember
//= require ember-template-compiler
//= require ember-data
//= require localstorage_adapter
//= require bootstrap/modal
//= require bootstrap/transition
//= require pongstagr.am
//= require stripe
//= require select2
//= require_self
//= require ./store
//= require_tree ./mixins
//= require_tree ./services
//= require_tree ./models
//= require_tree ./controllers
//= require_tree ./views
//= require_tree ./helpers
//= require_tree ./components
//= require_tree ./templates
//= require_tree ./routes
//= require_tree ./adapters
//= require_tree ./serializers
//= require ./router

// for more details see: http://emberjs.com/guides/application/
window.App = Em.Application.create({
  LOG_ACTIVE_GENERATION: true,
  LOG_MODULE_RESOLVER: true,
  LOG_TRANSITIONS: true,
  LOG_TRANSITIONS_INTERNAL: true,
  LOG_VIEW_LOOKUPS: true,
  LOG_BINDINGS: true
});

Em.RSVP.configure('onerror', function(error) {
	if (error instanceof Error) {
		Em.Logger.assert(false, error);
		return Em.Logger.error(error.stack);
}
});

App.CONSTANTS = {
  CART: 'Trashbags:cart'
};
