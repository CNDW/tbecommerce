App.CustomRoute = Em.Route.extend
  model: ->
    store = @store
    model = {}
    store.find('custom_item', {inShop: true}).then (data)->
      if (data.content.length)
        model = data.content[0]
    , (reason)->
      item = store.createRecord 'custom_item',
          inShop: true
      item.save()
      model = item

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
      featured: @store.filter 'product', (record)->
        record.get 'featured'
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
      controller.set 'categories', data.categories
      controller.set 'colors', data.colors
      controller.set 'featuredItems', data.featured


  afterModel: (model, transition)->
    return if model.get('noProduct')
    controller = @controllerFor('custom')
    controller.set 'selectedColors', model.get('selectedColors.content')
    controller.set 'options', model.get('customOptions.content')
    controller.setFills()


  actions:
    setCustomProduct: (product)->
      customItem = @modelFor('custom')
      customItem.set('product_id', product.get('id'))
      customItem.set('price', product.get('price'))
      customItem.unloadRelationships()
      customItem.reloadOptions(product)
      @setupCustomItem()


#-------------------------------------------
# private
#-------------------------------------------
  setupCustomItem: ->
    customItem = @modelFor('custom')
    @controller.set 'selectedColors', customItem.get('selectedColors.content')
    @controller.set 'options', customItem.get('customOptions.content')
    @controller.setFills()


