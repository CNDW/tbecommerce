App.InstockRoute = Em.Route.extend
  model: ->
    @store.find('variant')

App.InstockItemRoute = Em.Route.extend
  model: (params)->
    @store.find 'variant', params.variant_id