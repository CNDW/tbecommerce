App.InstockRoute = Em.Route.extend
  model: ->
    @store.findAll('variant')

App.InstockItemRoute = Em.Route.extend
  model: (params)->
    @store.findAll 'variant', params.variant_id
