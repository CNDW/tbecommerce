App.CompletedOrderMixin = Em.Mixin.create({
  completedReroute(order) {
    if (order.get('checkoutStep') > 3) {
      return this.transitionTo('order.completed', order);
    }
  }
});

App.OrderRoute = Em.Route.extend({

  actions: {
    error() {
      return this.transitionTo('cart');
    }
  }
});

App.OrderIndexRoute = Em.Route.extend(App.CompletedOrderMixin, {

  afterModel(model) {
    this.completedReroute(model);
    if (model.get('shipAddress') === null) {
      model.set('shipAddress', this.store.createRecord('shipAddress'));
      return model.set('billAddress', this.store.createRecord('billAddress'));
    }
  },

  deactivate() {
    let order = this.modelFor('order.index');
    if (order.get('isDirty')) { return order.updateAddresses(); }
  },

  actions: {
    completeCheckoutAddresses() {
      let self = this;
      let order = this.modelFor('order.index');
      return order.updateAddresses('alertError').then((responseJSON) => {
        return order.advanceState('delivery').then(() => self.transitionTo('order.shipping'));
      });
    }
  }
});

App.OrderShippingRoute = Em.Route.extend(App.CompletedOrderMixin, {

  afterModel(model, transition) {
    this.completedReroute(model);
    if (model.get('checkoutStep') <= 1) {
      return this.transitionTo('order.index', model);
    }
  },

  actions: {
    completeCheckoutShipping() {
      let self = this;
      let order = this.modelFor('order.shipping');
      return order.updateShipments('alertError').then(() =>
        order.advanceState('payment').then(() => self.transitionTo('order.payment'))
      );
    }
  }
});

App.OrderPaymentRoute = Em.Route.extend(App.CompletedOrderMixin, {

  afterModel(model, transition) {
    this.completedReroute(model);
    if (model.get('checkoutStep') <= 2) {
      return this.transitionTo('order.shipping', model);
    }
  },

  setupController(controller, model) {
    return this.store.find('card').then((data) => {
      controller.set('model', model);
      let unused_cards = data.filterBy('used', false);
      controller.set('cards', unused_cards);
      // if Em.empty(unused_cards)
      let card = this.store.createRecord('card');
      return controller.set('currentCard', card);
    });
  },
      // else
      //   controller.set 'currentCard', unused_cards.get('firstObject')

  actions: {
    submitOrder(card, order) {
      let self = this;
      return card.createToken(order).then(() =>
        order.createPayment(order.get('paymentMethods').findBy('methodType', 'stripe'), card).then(() =>
          order.completePayment().then(function() {
            card.set('used', true);
            // card.save()
            return self.transitionTo('order.completed', order);
          })
        )
      );
    }
  }
});

App.OrderCompletedRoute = Em.Route.extend({

  afterModel(model, transition) {
    if (model.get('checkoutStep') <= 3) {
      this.transitionTo('order.payment', model);
    }
    let cart = this.modelFor('application');
    return cart.resetCart();
  }
});

