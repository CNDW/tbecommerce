App.CartController = Em.Controller.extend({
  total: Em.computed('model.lineItems.[].total', function() {
    if (!this.get('model.lineItems')) { return 0; }
    return this.get('model.lineItems').reduce((prev, item) => {
      return prev + Number(item.get('total'));
    }, 0);
  }),

  displayTotal: Em.computed('total', function() {
    return `$${Number(this.get('total')).toFixed(2)}`;
  })
});
