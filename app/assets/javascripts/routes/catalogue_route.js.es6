App.CatalogueRoute = Em.Route.extend({
  model() {
    return this.store.peekAll('product');
  }
});

App.CatalogueIndexRoute = Em.Route.extend({
  model() {
    return this.store.peekAll('product');
  }
  // wat?
  // setupController(controller, model){
  //   controller.set('model', model);
  //   return model.mapBy('product_type').uniq().forEach(function(item){
  //     let item_name = item;
  //     return this[0].set(item, this[1].store.filter('product', function(product){
  //       let x = product.get('product_type');
  //       return x === item_name && product.get('in_catalogue');
  //     }));
  //   } [controller, model]);
  // }
});

var CatalogueMixin = Em.Mixin.create({
  productCategory: 'bag',

  model() {
    let category = this.get('productCategory');
    return this.store.peekAll('product').filter((product) => {
      let x = product.get('productCategory')
      return x === category && product.get('inCatalogue');
    });
  },

  renderTemplate(controller){
    return this.render('catalogue/index', {controller});
  }
});

App.CatalogueBagsRoute = Em.Route.extend(CatalogueMixin);

App.CatalogueApparelRoute = Em.Route.extend(CatalogueMixin, {
  productCategory: 'apparel'
});

App.CatalogueUtilityRoute = Em.Route.extend(CatalogueMixin, {
  productCategory: 'utility'
});
