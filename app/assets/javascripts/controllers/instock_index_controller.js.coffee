App.InstockIndexController = Em.ArrayController.extend
  types: Em.computed 'model', ->
    @get('model').mapBy('product.product_category').uniq()

  instock_collections: Em.computed.map 'types', (type)->
    Em.Object.create
      name: ((name)->
        return "bags" if name is "bag"
        return name
      )(type)
      items: this.get('model').filter (model)->
        model.get('category') is type and model.get('is_master') is false
      .sortBy('price')

