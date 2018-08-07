App.InstockIndexController = Em.Controller.extend({
  types: Em.computed('model', function() {
    return this.get('model').mapBy('product.productCategory').uniq();
  }),

  instockCollections: Em.computed('bag.[]', 'utility.[]', 'apparel.[]', 'types', function() {
    return this.get('types').map((type) => {
      return Em.Object.create({
        name: type === 'bag' ? 'bags' : type,
        items: this.get(type)
      });
    });
  }),

  inventory: Em.computed('model.@each.totalInCart', function(){
    return this.get('model')
      .filter((model) => !model.get('isMaster') && model.get('totalNotInCart') > 0)
      .sortBy('price');
  }),

  bag: Em.computed.filterBy('inventory', 'category', 'bag'),
  utility: Em.computed.filterBy('inventory', 'category', 'utility'),
  apparel: Em.computed.filterBy('inventory', 'category', 'apparel')
});

App.InstockItemController = Em.Controller.extend({
  isUnavailable: Em.computed.alias('model.isUnavailable')
});
