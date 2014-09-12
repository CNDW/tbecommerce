App.CustomIndexRoute = Em.Route.extend
  model: (params)->
    @store.createRecord 'custom-item'
  setupController: (controller, model)->
    @_super controller, model
    Em.RSVP.hash(
      catalogue: @store.find('product')
      controller: controller
    ).then (data)->
      data.catalogue.mapBy('product_category').uniq().forEach (item)->
        @store.filter.mapBy(item).uniq().forEach (item)->
          debugger
        , this
      , data
