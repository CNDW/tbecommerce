let { ORDER_TOKEN, ORDER_NUMBER } = App.CONSTANTS;
let { Promise } = Em.RSVP;

function getLocalStorageItem(item) {
  try {
    return localStorage.getItem(item);
  } catch (err) {
    return null;
  }
}

App.CartService = Em.Service.extend(App.RequestableMixin, {
  store: Em.inject.service('store'),

  order: null,
  orderNumber: getLocalStorageItem(ORDER_NUMBER),
  orderToken: getLocalStorageItem(ORDER_TOKEN),

  hasNumber: Em.computed.notEmpty('orderNumber'),
  hasToken: Em.computed.notEmpty('orderToken'),
  hasOrderData: Em.computed.and('hasNumber', 'hasToken'),
  isCreated: Em.computed.alias('hasToken'),

  init() {
    this._super(...arguments);
    this.getOrder();
  },

  setOrder(order = null) {
    const orderNumber = order ? order.get('number') : null
    const orderToken = order ? order.get('token') : null
    this.setProperties({
      order,
      orderNumber,
      orderToken
    });
    try {
      localStorage.setItem(ORDER_NUMBER, orderNumber);
      localStorage.setItem(ORDER_TOKEN, orderToken);
    } catch (err) {}
  },

  storeOrderFromApi(payload) {
    const store = this.get('store');

    store.pushPayload('order', {order: payload});
    const order = store.peekRecord('order', payload.id);

    this.setOrder(order);
    return order;
  },

  resetCart() {
    this.setOrder(null);

    return this.getOrder();
  },

  getOrder() {
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
    const url = `api/orders/${this.get('orderNumber')}?order_token=${this.get('orderToken')}`
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
  },

  removeFromCart(lineItem) {
    return this.getOrder()
      .then(order => order.removeLineItem(lineItem));
  },
});
