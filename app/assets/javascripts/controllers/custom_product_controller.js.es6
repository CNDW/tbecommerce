App.CustomProductController = Em.Controller.extend({
  customController: Em.inject.controller('custom'),
  products: Em.computed.alias('customController.products'),

  categoryList: Em.computed('products', function() {
    return this.get('products').mapBy('category').uniq();
  }),

  categories: Em.computed.map('categoryList', function(category) {
    let self = this;
    let models = this.get('products').filterBy('category', category);
    return {
      name: category,
      types: models.mapBy('productType').uniq().map(function(type) {
        let items = self.get('products').filterBy('productType', type);
        return {
          name: type,
          items: items.sortBy('price'),
          averagePrice: (items.mapBy('price').reduce((sum, add) => {
            sum + add;
          }, 0) / items.length)
        };
      }).sortBy('averagePrice')
    };
  })
});
