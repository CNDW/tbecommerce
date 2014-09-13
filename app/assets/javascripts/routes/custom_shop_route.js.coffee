App.CustomShopRoute = Em.Route.extend
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
    ).then (data)->
      data.categories.forEach (category)->
        category.types = category.models.mapBy('product_type').uniq().map (type)->
          {name: type}
        category.types.forEach (type)->
          type.items = @models.filterBy 'product_type', type.name
        , category
      data.controller.set 'categories', data.categories

App.CustomIndexRoute = App.CustomShopRoute.extend
  model: (params)->
    @store.find('custom-item').then (data)->
      if (data.content.length is 0)
        item = data.store.createRecord 'custom-item'
        item.save()
      else
        item = data.content[0]
      return item

    # @store.find('custom-item').then (data)->
    #   return data
  actions:
    setCustomProduct: (product)->
      custom_item = @modelFor 'custom.index'
      custom_item.set 'product', product
      custom_item.save()

App.CustomFeaturesRoute = App.CustomShopRoute.extend()
App.CustomExtrasRoute = App.CustomShopRoute.extend()
App.CustomColorsRoute = App.CustomShopRoute.extend()
