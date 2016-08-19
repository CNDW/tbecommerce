var CatalogueMixin = Em.Mixin.create({
  types: Em.computed('model.[]', function() {
    let unsorted = this.get('model').mapBy('productType').uniq().map((type) => {
      let items = this.get('model').filterBy('productType', type).sortBy('price');
      let total = 0;
      items.forEach((item) => {
        total += item.get('price');
      });
      let average = total / items.get('length');
      return {name: type, items, averagePrice: average};
    });
    return unsorted.sortBy('averagePrice');
  })
});

App.CatalogueIndexController = Em.Controller.extend(CatalogueMixin);
App.CatalogueBagsController = Em.Controller.extend(CatalogueMixin, {
  category: 'Bags'
});
App.CatalogueUtilityController = Em.Controller.extend(CatalogueMixin, {
  category: 'Utility'
});
App.CatalogueApparelController = Em.Controller.extend(CatalogueMixin, {
  category: 'Apparel'
});
