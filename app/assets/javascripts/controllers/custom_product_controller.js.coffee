App.CustomProductController = Em.ObjectController.extend
  needs: ['custom']
  products: Em.computed.alias 'controllers.custom.products'

  category_list: Em.computed 'products', ->
    @get('products').mapBy('category').uniq()

  categories: Em.computed.map 'category_list', (category)->
    self = this
    models = @get('products').filterBy 'category', category
    return_category =
      name: category
      types: models.mapBy('product_type').uniq().map (type)->
        items = self.get('products').filterBy('product_type', type)
        prices = items.mapBy 'price'
        name: type
        items: items.sortBy 'price'
        average_price: (items.mapBy('price').reduce((sum, add)->
          sum + add
        , 0) / items.length)
      .sortBy 'average_price'

  # actions:
  #   clickOption: (selection)->
  #     selection.toggleProperty('selected')
  #     return false