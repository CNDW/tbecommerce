App.ApplicationController = Em.Controller.extend({
  catalogueActive: false,

  actions: {
    toggleCatalogue() {
      this.toggleProperty('catalogueActive');
    },
    deactivateCatalogue() {
      this.set('catalogueActive', false);
    }
  }
});
