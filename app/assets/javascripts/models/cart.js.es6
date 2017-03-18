App.Cart = DS.Model.extend(App.RequestableMixin, {
  token: DS.attr('string', {defaultValue: null}),
  number: DS.attr('string', {defaultValue: null}),
  orderId: DS.attr('string', {defaultValue: null}),

  order: Em.computed('orderId', function() {
    return this.store.peekRecord('order', this.get('orderId'));
  }),

  getOrder() {
    let store = this.get('store');
    return new Em.RSVP.Promise((resolve, reject) => {
      let order = store.peekRecord('order', this.get('orderId'));
      resolve(order || this.fetchOrder());
    });
  },

  resetCart() {
    this.set('token', null);
    return this.createOrder();
  },

  fetchOrder() {
    let store = this.get('store');
    return this.request({
      url: `api/orders/${self.get('number')}?order_token=${this.get('token')}`
    }).then((payload) => {
      store.pushPayload('order', {order: payload});
      this.setProperties({
        orderId: payload.order_id,
        token: payload.token,
        number: payload.number
      });
      this.save();

      return store.peekRecord('order', payload.id);
    }, () => {
      return this.createOrder();
    });
  },

  createOrder() {
    let store = this.get('store');
    return this.request({
      url: 'api/orders',
      type: 'POST'
    }).then((payload) => {
      store.pushPayload('order', {order: payload});

      this.setProperties({
        orderId: payload.order_id,
        token: payload.token,
        number: payload.number
      });

      this.save();

      return store.peekRecord('order', payload.id);
    });
  }
});
