App.Cart = DS.Model.extend(App.RequestableMixin, {
  token: DS.attr('string', {defaultValue: null}),
  number: DS.attr('string', {defaultValue: null}),
  orderId: DS.attr('string', {defaultValue: null}),

  // order: (function() {
  //   return this.store.findRecord('order', this.get('order_id'));
  // }).property('order_id'),

  getOrder() {
    let store = this.get('store');
    return new Promise((resolve, reject) => {
      let order = store.peekRecord('order', this.get('orderId'));
      resolve(order || this.fetchOrder());
    });
  },

  resetCart() {
    let self = this;
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
        orderId: orderId,
        token: payload.token,
        number: payload.number
      });
      this.save();

      return store.peekRecord('order', payload.id);
    }).catch(() => {
      return this.createOrder()
    })
  },

  createOrder() {
    let store = this.get('store');
    return this.request({
      url: 'api/orders',
      type: 'POST'
    }).then((payload) => {
      store.pushPayload('order', {order: payload});

      this.setProperties({
        orderId: orderId,
        token: payload.token,
        number: payload.number
      });

      this.save();

      return store.peekRecord('order', payload.id);
    });
  }
});
