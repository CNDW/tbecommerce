App.OrderIndexController = Em.Controller.extend({
  actions: {
    acceptChanges() {
      return this.get('model');
    }
  }
});

App.OrderPaymentController = Em.Controller.extend({
  cards: Em.A(),
  currentCard: ''
});
