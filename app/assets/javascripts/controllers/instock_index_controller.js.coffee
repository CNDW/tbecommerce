App.InstockIndexController = Em.ArrayController.extend
  types: Em.computed 'model', ->
    @get('model').mapBy('product.product_category').uniq()

  instock_collections: Em.computed 'bag', 'utility', 'apparel', ->
    @get('types').map (type)->
      Em.Object.create
        name: ((name)->
          return "bags" if name is "bag"
          return name
        )(type)
        items: this.get(type)
    , this
  bag: Em.computed 'model.@each.total_in_cart', ->
    this.get('model').filter (model)->
      model.get('category') is 'bag' and model.get('is_master') is false and model.get('total_not_in_cart') > 0
    .sortBy('price')

  utility: Em.computed 'model.@each.total_in_cart', ->
    this.get('model').filter (model)->
      model.get('category') is 'utility' and model.get('is_master') is false and model.get('total_not_in_cart') > 0
    .sortBy('price')

  apparel: Em.computed 'model.@each.total_in_cart', ->
    this.get('model').filter (model)->
      model.get('category') is 'apparel' and model.get('is_master') is false and model.get('total_not_in_cart') > 0
    .sortBy('price')

App.InstockItemController = Em.ObjectController.extend
  isUnavailable: Em.computed.alias 'model.isUnavailable'