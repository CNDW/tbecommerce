App.CatalogueIndexController = Em.ArrayController.extend
  types: (->
    @get('model').mapBy('type').uniq().map (item)->
      {name: item, items: @get item}
    , @
  ).property('model')
  category: 'catalogue'



App.CatalogueBagsController = App.CatalogueIndexController.extend
  category: 'bags'
App.CatalogueUtilityController = App.CatalogueIndexController.extend
  category: 'utility'
App.CatalogueApparelController = App.CatalogueIndexController.extend
  category: 'apparel'
