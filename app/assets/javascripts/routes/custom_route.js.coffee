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
      colors: @store.all 'color_value'
    ).then (data)->
      data.categories.forEach (category)->
        category.types = category.models.mapBy('product_type').uniq().map (type)->
          {name: type}
        category.types.forEach (type)->
          type.items = @models.filterBy 'product_type', type.name
          prices = type.items.mapBy 'price'
          type.averagePrice = 0
          prices.forEach (price)->
            type.averagePrice += price
          type.averagePrice = type.averagePrice / prices.length
          type.items = type.items.sortBy 'price'
        , category
        category.types.sortBy 'averagePrice'
      data.controller.set 'categories', data.categories
      data.controller.set 'colors', data.colors

  actions:
    setCustomProduct: (product)->
      customItem = @modelFor('custom')
      @store.unloadAll('selected_color')
      @store.unloadAll('custom_option')
      customItem.set('product_id', product.get('id'))

      colorTypes = product.get('colorTypes')
      selectedColors = colorTypes.map (colorType)->
        selection = @store.createRecord 'selected_color',
          colorType_id: colorType.get 'id'
        selection.get 'colorType'
        selection.set('customItem', customItem)
        return selection
      , this

      @controller.set 'selectedColors', selectedColors
      @controller.setFills()

      customOptions = []
      options = []
      product.get('optionTypes').forEach (optionType)->
        values = optionType.get('optionValues').map (value)->
          selection = @store.createRecord 'custom_option',
            optionValue_id: value.get 'id'
          options.push(selection.get 'optionValue')
          return selection
        , this
        customOptions = customOptions.concat(values)
      , this
      customItem.get('customOptions').pushObjects(customOptions)

      @controller.set 'options', customOptions

      customItem.save()

    selectColor: (color, selection)->
      selection.set 'colorValue_id', color.get('id')
      selection.set 'name', color.get('name')
      @controller.setFills()
      return selection

