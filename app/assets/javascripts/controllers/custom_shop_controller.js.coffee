App.CustomIndexController = Em.Controller.extend
  actions:
    setCustomProduct: (product)->
      return if product.get('id') is @model.get('product_id')
      custom_item = @get 'model'
      if custom_item.get 'noProduct'
        custom_item.set 'product_id', product.get 'id'
        custom_item.save()
      else
        store = @store
        @model.destroyRecord()
        @model = store.createRecord 'custom_item',
          product_id: product.get 'id'
        @model.save()


App.CustomColorsController = Em.Controller.extend
  actions:
    selectColor: (color, selection)->
      selection.set 'colorValue_id', color.get 'id'
      selection.save()
      $(".#{selection.get('selector')}").css('fill', "url(##{color.get('name')}-pattern)")
