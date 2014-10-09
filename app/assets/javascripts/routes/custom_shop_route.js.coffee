App.CustomShopRoute = Em.Route.extend
  shop_steps: ['custom.index', 'custom.colors', 'custom.features', 'custom.extras']

  afterModel: (model, transition)->
    @transitionTo @shop_steps[model.get 'stepIndex'] if @step_number > model.get 'stepIndex'

App.CustomIndexRoute = App.CustomShopRoute.extend
  step_number: 0
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

App.CustomColorsRoute = App.CustomShopRoute.extend
  step_number: 1

  setupController: (controller, model)->
    @_super controller, model
    Em.RSVP.hash(
      colorOptions: model.get('colorOptions')
      selectedColors: model.get('selectedColors')
      store: @store
    ).then (data)->
      data.colorOptions.forEach (colorOption)->
        colorType_id = colorOption.get 'id'
        if not @selectedColors.anyBy('colorType_id', colorType_id)
          new_selection = @store.createRecord 'selected_color',
            colorType_id: colorType_id
          @selectedColors.addRecord new_selection
          @selectedColors.save()
      , data

App.CustomFeaturesRoute = App.CustomShopRoute.extend
  step_number: 2
App.CustomExtrasRoute = App.CustomShopRoute.extend
  step_number: 3
