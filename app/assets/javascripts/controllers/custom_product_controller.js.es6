App.CustomProductController = Em.Controller.extend({
  needs: ['custom'],
  products: Em.computed.alias('controllers.custom.products'),

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
          average_price: (items.mapBy('price').reduce((sum, add) => {
            sum + add;
          }, 0) / items.length)
        };
      })
      .sortBy('average_price')
    };
  })
});
