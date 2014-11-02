App.CustomRoute = Em.Route.extend

  setupController: (controller, model)->
    @_super controller, model
    self = this
    products = @store.all('product')
    Em.RSVP.hash
      controller: controller
      categories: [
        name: 'bag'
        types: []
        models: products.filterBy 'category', 'bag'
      ,
        name: 'apparel'
        types: []
        models: products.filterBy 'category', 'apparel'
      ,
        name: 'utility'
        types: []
        models: products.filterBy 'category', 'utility'
      ]
      colors: @store.all 'color_value'
      featured: products.filterBy('featured', true)
      order: @modelFor 'cart'
    .then (data)->
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
      controller.set 'order', data.order

  afterModel: (model, transition)->
    controller = @controllerFor('custom')
    if model.get('noProduct')
      controller.set 'builderStep', 1
    else
      controller.set 'selectedColors', model.get('selectedColors')
      controller.set 'options', model.get('customOptions')
      controller.setFills()


  actions:
    setCustomProduct: (product)->
      customItem = @modelFor('custom')
      customItem.set('product_id', product.get('id'))
      customItem.reloadRelationships()
      @setupCustomItem()


#-------------------------------------------
# private
#-------------------------------------------
  setupCustomItem: ->
    customItem = @modelFor('custom')
    @controller.set 'selectedColors', customItem.get('selectedColors')
    @controller.set 'options', customItem.get('customOptions')
    @controller.setFills()


