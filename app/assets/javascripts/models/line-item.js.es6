App.LineItem = DS.Model.extend({
  quantity: DS.attr('number'),
  price: DS.attr('string'),
  singleDisplayAmmount: DS.attr('string'),
  total: DS.attr('string'),
  displayTotal: DS.attr('string'),

  customItem: DS.belongsTo('custom-item'),
  order: DS.belongsTo('order'),
  customItemHash: DS.attr('string'),
  variant: DS.belongsTo('variant'),
  orderNotes: DS.attr('string'),

  isCustom: Em.computed.alias('variant.isMaster'),

  didLoad() {
    if (this.get('variant')) {
      return this.get('variant').set('totalInCart', this.get('quantity'));
    }
  },

  orderIsComplete: Em.computed.alias('order.isComplete'),

  state: Em.computed('order', function() {
    return this.get('order') === null ? 'precart' : this.get('order.state');
  }),

  inOrder: Em.computed('order', function() {
    return this.get('order') !== null;
  }),

  inCart: Em.computed('inOrder', 'isComplete', function() {
    return !this.get('inOrder') && this.get('isComplete');
  }),

  name: Em.computed('customItem.name', 'variant.name', 'variant.instockDescription', function() {
    if (this.get('customItem.name')) {
      return `Custom ${this.get('customItem.name')}`;
    }
    return `${this.get('variant.name')}, ${this.get('variant.instockDescription')}`;
  }),

  remove() {
    this.get('customItem').removeLineItem();
    this.set('order', null);
    return this.destroyRecord();
  }
});
