App.CustomIndexController = Em.Controller.extend
  actions:
    setCustomProduct: (product)->
      return if product.get('id') is @model.get('product_id')
      custom_item = @model
      if custom_item.get 'noProduct'
        custom_item.set 'product_id', product.get 'id'
        custom_item.save()
      else
        store = @store
        @model.destroyRecord()
        new_custom_item = store.createRecord 'custom_item',
          product_id: product.get 'id'
        @model = new_custom_item
        @model.save()

App.CustomColorsController = Em.Controller.extend
  actions:
    selectColor: (selectedColorValue, selectedColorType)->
      customItem = @model
      selectedColors = @model.get 'selectedColors'
      selector = selectedColorType.get 'selector'
      if customItem.get('noSelectedColors') or not selectedColors.anyBy('selector', selector)
        selectedColor = @store.createRecord 'selected_color',
          swatch: selectedColorValue.get 'small_url'
          name: selectedColorValue.get 'name'
          selector: selectedColorType.get 'selector'
        selectedColors.pushRecord selectedColor
      else
        selectedColor = selectedColors.findBy 'selector', selector
        selectedColor.set 'swatch', selectedColorValue.get 'small_url'
        selectedColor.set 'name', selectedColorValue.get 'name'
      customItem.save()
