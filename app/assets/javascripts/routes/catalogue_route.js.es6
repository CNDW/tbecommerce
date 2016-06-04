App.CatalogueRoute = Em.Route.extend({
  model() {
    return this.store.peekAll('product');
  }
});

App.CatalogueIndexRoute = Em.Route.extend({
  model() {
    return this.store.peekAll('product');
  }
});

var CatalogueMixin = Em.Mixin.create({
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

App.CatalogueBagsRoute = Em.Route.extend(CatalogueMixin, {
  productCategory: 'bag'
});

App.CatalogueApparelRoute = Em.Route.extend(CatalogueMixin, {
  productCategory: 'apparel'
});

App.CatalogueUtilityRoute = Em.Route.extend(CatalogueMixin, {
  productCategory: 'utility'
});
