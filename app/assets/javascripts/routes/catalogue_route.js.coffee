App.CatalogueRoute = Em.Route.extend
  model: ->
    @store.find 'product'

App.CatalogueIndexRoute = Em.Route.extend
  redirect: ->
    @transitionTo 'bags'

App.CatalogueBagsRoute = Em.Route.extend
  model: ->
    model = @store.filter 'product', (product)->
      x = product.get 'product_category'
      x == 'bag'
  renderTemplate: (controller)->
    @render 'catalogue/index', controller: controller

App.CatalogueApparelRoute = Em.Route.extend
  model: ->
    model = @store.filter 'product', (product)->
      x = product.get 'product_category'
      x == 'apparel'
  renderTemplate: (controller)->
    @render 'catalogue/index', controller: controller

App.CatalogueUtilityRoute = Em.Route.extend
  model: ->
    model = @store.filter 'product', (product)->
      x = product.get 'product_category'
      x == 'utility'
  renderTemplate: (controller)->
    @render 'catalogue/index', controller: controller