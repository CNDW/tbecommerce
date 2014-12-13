App.InstockController = Em.ArrayController.extend
  types: Em.computed 'model', ->
    @get('model').mapBy('product.product_category').uniq()

