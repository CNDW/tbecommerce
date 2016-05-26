App.CatalogueRoute = Em.Route.extend
  model: ->
    @store.peekAll 'product'

App.CatalogueIndexRoute = Em.Route.extend
  model: ->
    @store.peekAll 'product'
  setupController: (controller, model)->
    controller.set 'model', model
    model.mapBy('product_type').uniq().forEach (item)->
      item_name = item
      this[0].set item, this[1].store.filter 'product', (product)->
        x = product.get 'product_type'
        x == item_name and product.get('in_catalogue')
    , [controller, model]
  renderTemplate: (controller)->
    @render 'catalogue/index', controller: controller

App.CatalogueBagsRoute = App.CatalogueIndexRoute.extend
  model: ->
    model = @store.filter 'product', (product)->
      x = product.get 'product_category'
      x is 'bag' and product.get('in_catalogue')
  renderTemplate: (controller)->
    @render 'catalogue/index', controller: controller

App.CatalogueApparelRoute = App.CatalogueIndexRoute.extend
  model: ->
    model = @store.filter 'product', (product)->
      x = product.get 'product_category'
      x is 'apparel' and product.get('in_catalogue')
  renderTemplate: (controller)->
    @render 'catalogue/index', controller: controller

App.CatalogueUtilityRoute = App.CatalogueIndexRoute.extend
  model: ->
    model = @store.filter 'product', (product)->
      x = product.get 'product_category'
      x is 'utility' and product.get('in_catalogue')
  renderTemplate: (controller)->
    @render 'catalogue/index', controller: controller
