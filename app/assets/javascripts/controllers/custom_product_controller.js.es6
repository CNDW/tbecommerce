App.CustomProductController = Em.Controller.extend({
  needs: ['custom'],
  products: Em.computed.alias('controllers.custom.products'),

  category_list: Em.computed('products', function() {
    return this.get('products').mapBy('category').uniq();
  }),

  categories: Em.computed.map('category_list', function(category){
    let return_category;
    let self = this;
    let models = this.get('products').filterBy('category', category);
    return return_category = {
      name: category,
      types: models.mapBy('product_type').uniq().map(function(type){
        let items = self.get('products').filterBy('product_type', type);
        let prices = items.mapBy('price');
        return {
          name: type,
          items: items.sortBy('price'),
          average_price: (items.mapBy('price').reduce((sum, add) => sum + add
          , 0) / items.length)
        };
      })
      .sortBy('average_price')
    };
  })
});
