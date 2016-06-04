App.CustomRoute = Em.Route.extend({

  actions: {
    error() {
      return this.transitionTo('custom-shop');
    }
  }
});
