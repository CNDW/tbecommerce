App.CustomIndexRoute = Em.Route.extend
  model: (params)->
    @store.createRecord 'custom-item'
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
        category.types = category.models.mapBy('type').uniq().map (type)->
          {name: type}
        category.types.forEach (type)->
          type.items = @models.filterBy 'type', type.name
        , category
      data.controller.set 'categories', data.categories
