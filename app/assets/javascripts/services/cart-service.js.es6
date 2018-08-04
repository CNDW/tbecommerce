let { ORDER_TOKEN, ORDER_NUMBER } = App.CONSTANTS;
let { Promise } = Em.RSVP;

App.CartService = Em.Service.extend(App.RequestableMixin, {
  store: Em.inject.service('store'),

  order: null,
  orderNumber: null,
  orderToken: null,

  hasNumber: Em.computed.notEmpty('orderNumber'),
  hasToken: Em.computed.notEmpty('orderToken'),
  hasOrderData: Em.computed.and('hasNumber', 'hasToken'),
  isCreated: Em.computed.alias('hasToken'),

  init() {
    this._super(...arguments);
    try {
      this.setProperties({
        orderNumber: localStorage.getItem(ORDER_NUMBER),
        orderToken: localStorage.getItem(ORDER_TOKEN)
      });
    } catch (err) {}

    this.getOrder();
  },

  storeOrderFromApi(payload) {
    const store = this.get('store');

    store.pushPayload('order', {order: payload});
    const order = store.peekRecord('order', payload.id);

    this.setProperties({
      order,
      orderNumber: order.number,
      orderToken: order.token,
    });
    return order;
  },

  resetCart() {
    this.setProperties({
      order: null,
      orderNumber: null,
      orderToken: null,
    });

    return this.getOrder();
  },

  getOrder() {
    console.log('')
    if (this.get('order')) {
      return Promise.resolve(this.get('order'));
    }

    return this.fetchOrder();
  },

  storePromise(p) {
    this.orderFetchPromise = p;
    return p
      .then((result) => {
        this.orderFetchPromise = null;
        return result;
      })
      .catch((err) => {
        this.orderFetchPromise = null;
        throw err;
      })
  },

  fetchOrder() {
    if (this.orderFetchPromise) {
      return this.orderFetchPromise;
    }
    if (!this.get('hasOrderData')) {
      const promise = this.createOrder()
        .then((payload) => this.storeOrderFromApi(payload));
      return this.storePromise(promise);
    }
    let store = this.get('store');
    const url = `api/orders/${this.get('number')}?order_token=${this.get('token')}`
    const promise = this.request({ url })
      .catch(() => this.createOrder())
      .then((payload) => this.storeOrderFromApi(payload));
    return this.storePromise(promise);
  },

  createOrder() {
    let store = this.get('store');
    return this.request({
      url: 'api/orders',
      type: 'POST'
    });
  }
});
