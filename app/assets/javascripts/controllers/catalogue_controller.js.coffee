App.CatalogueIndexController = Em.Controller.extend
  types: Em.computed 'model', ->
    unsorted = @get('model').mapBy('product_type').uniq().map (item)->
      items = @get(item).sortBy 'price'
      total = 0
      items.forEach (item)->
        total += item.get 'price'
      average = total / items.get 'length'
      {name: item, items: items, averagePrice: average}
    , this
    unsorted.sortBy 'averagePrice'

  category: 'catalogue'



App.CatalogueBagsController = App.CatalogueIndexController.extend
  category: 'bags'
App.CatalogueUtilityController = App.CatalogueIndexController.extend
  category: 'utility'
App.CatalogueApparelController = App.CatalogueIndexController.extend
  category: 'apparel'
