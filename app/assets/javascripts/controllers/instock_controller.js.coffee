App.InstockController = Em.ArrayController.extend
  types: Em.computed 'model', ->
    @get('model').mapBy('product.product_category').uniq()

  instock_collections: Em.computed.map 'types', (type)->
    Em.Object.create
      name: Em.String.pluralize(type)
      items: this.get('model').filter (model)->
        model.get('category') is type

