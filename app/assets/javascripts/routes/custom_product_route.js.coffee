App.CustomProductRoute = Em.Route.extend

  actions:
    setCustomProduct: (product)->
      customItem = @modelFor('custom')
      customItem.set('product_id', product.get('id'))
      customItem.reloadRelationships()
      @transitionTo 'custom.colors', customItem