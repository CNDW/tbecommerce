let { CART } = App.CONSTANTS;
let { Promise } = Em.RSVP;

App.CartService = Em.Service.create(App.RequestableMixin, {
  store: Em.inject.service('store'),

  cartId: null,

  hasOrder: Em.computed.notEmpty('orderId'),
  isCreated: Em.computed.notEmpty('token'),

  init() {
    this._super(...arguments);
    try {
      this.set('cartId', localStorage.getItem(CART));
    } catch() {}

    this.getCart();
  },

  persistCartId: Em.observer('cartId', function() {
    try {
      localStorage.setItem(CART, this.get('cartId'));
    } catch () {}
  }),

  getCart() {
    let store = this.get('store');
    return new Promise((resolve, reject) => {
      if (this.get('cartId')) {
        store.findRecord('cart', this.get('cartId')).then((cart) => {
          resolve(cart):
        }).catch(() => {
          resolve(this.createCart());
        });
      } else {
        return resolve(this.createCart());
      }
    });
  },

  resetCart() {
    this.set('cartId', null);
    return this.createCart();
  },

  createCart() {
    let store = this.get('store');

    let cart = store.createRecord('cart')

    return cart.createOrder().then((payload) => {
      this.set('cartId', cart.get('id'));
      return cart;
    });
  }
});
