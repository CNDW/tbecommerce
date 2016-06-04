
var CatalogueMixin = Em.Mixin.create({
  types: Em.computed('model.[]', function() {
    let unsorted = this.get('model').mapBy('productType').uniq().map((type) => {
      let items = this.get('model').filterBy('productType', type).sortBy('price');
      let total = 0;
      items.forEach((item) => {
        total += item.get('price');
      });
      let average = total / items.get('length');
      return {type: type, items, averagePrice: average};
    });
    return unsorted.sortBy('averagePrice');
  })
});

App.CatalogueIndexController = Em.Controller.extend(CatalogueMixin);
App.CatalogueBagsController = Em.Controller.extend(CatalogueMixin);
App.CatalogueUtilityController = Em.Controller.extend(CatalogueMixin);
App.CatalogueApparelController = Em.Controller.extend(CatalogueMixin);
