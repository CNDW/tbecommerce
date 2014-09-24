App.CustomRoute = Em.Route.extend
  model: (params)->
    @store.find('custom_item').then (data)->
      if (data.content.length is 0)
        item = data.store.createRecord 'custom_item'
        item.save()
      else
        item = data.content[0]
      return item
  setupController: (controller, model)->
    @_super controller, model
    Em.RSVP.hash(
      controller: controller
      categories: [
        {name: 'bag', types: [], models: @store.filter 'product', (product)->
          category = product.get 'category'
          category is 'bag'
        }
        {name: 'apparel', types: [], models: @store.filter 'product', (product)->
          category = product.get 'category'
          category is 'apparel'
        }
        {name: 'utility', types: [], models: @store.filter 'product', (product)->
          category = product.get 'category'
          category is 'utility'
        }
      ]
      colors: @store.find 'color_value'
    ).then (data)->
      data.categories.forEach (category)->
        category.types = category.models.mapBy('product_type').uniq().map (type)->
          {name: type}
        category.types.forEach (type)->
          type.items = @models.filterBy 'product_type', type.name
        , category
      data.controller.set 'categories', data.categories
      data.controller.set 'colors', data.colors

  actions:
    setCustomProduct: (product)->
      @modelFor('custom').set('product_id', product.get('id'))
      colorTypes = product.get('colorTypes')
      colorSelections = @controller.get('selectedColors')
      if colorSelections
        colorSelections.forEach (selection)->
          @store.unloadRecord selection
        , this
      selectedColors = colorTypes.map (colorType)->
        selection = @store.createRecord 'selected_color',
          colorType_id: colorType.get 'id'
        selection.get 'colorType'
        return selection
      , this
      @controller.set 'selectedColors', selectedColors
      @controller.setFills()
      options = Em.A()
      product.get('optionTypes').forEach (optionType)->
        optionType.get('optionValues').forEach (value)->
          @pushObject(value)
        , this
      , options
      @controller.set 'options', options

    selectColor: (color, selection)->
      selection.set 'colorValue_id', color.get('id')
      selection.set 'name', color.get('name')
      @controller.setFills()
      return selection

