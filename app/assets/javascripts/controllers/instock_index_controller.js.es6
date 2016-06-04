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

  bag: Em.computed('model.@each.totalInCart', function() {
    return this.get('model').filter((model) => {
      return model.get('category') === 'bag' && model.get('isMaster') === false && model.get('totalNotInCart') > 0
    }).sortBy('price');
  }),

  utility: Em.computed('model.@each.totalInCart', function() {
    return this.get('model').filter((model) => {
      return model.get('category') === 'utility' && model.get('isMaster') === false && model.get('totalNotInCart') > 0
    }).sortBy('price');
  }),

  apparel: Em.computed('model.@each.totalInCart', function() {
    return this.get('model').filter((model) => {
      return model.get('category') === 'apparel' && model.get('isMaster') === false && model.get('totalNotInCart') > 0
    }).sortBy('price');
  })
});

App.InstockItemController = Em.Controller.extend({
  isUnavailable: Em.computed.alias('model.isUnavailable')
});
