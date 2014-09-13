App.CatalogueRoute = Em.Route.extend
  model: ->
    @store.find 'product'

App.CatalogueIndexRoute = Em.Route.extend
  model: ->
    @store.find 'product'
  setupController: (controller, model)->
    controller.set 'model', model
    model.mapBy('product_type').uniq().forEach (item)->
      item_name = item
      this[0].set item, this[1].store.filter 'product', (product)->
        x = product.get 'product_type'
        x == item_name
    , [controller, model]
  renderTemplate: (controller)->
    @render 'catalogue/index', controller: controller

App.CatalogueBagsRoute = App.CatalogueIndexRoute.extend
  model: ->
    model = @store.filter 'product', (product)->
      x = product.get 'product_category'
      x is 'bag'
  renderTemplate: (controller)->
    @render 'catalogue/index', controller: controller

App.CatalogueApparelRoute = App.CatalogueIndexRoute.extend
  model: ->
    model = @store.filter 'product', (product)->
      x = product.get 'product_category'
      x is 'apparel'
  renderTemplate: (controller)->
    @render 'catalogue/index', controller: controller

App.CatalogueUtilityRoute = App.CatalogueIndexRoute.extend
  model: ->
    model = @store.filter 'product', (product)->
      x = product.get 'product_category'
      x is 'utility'
  renderTemplate: (controller)->
    @render 'catalogue/index', controller: controller