App.CustomRoute = Em.Route.extend

  setupController: (controller, model)->
    @_super controller, model
    self = this
    products = @store.all('product')
    Em.RSVP.hash
      colors: @store.all 'color_value'
      order: @modelFor 'cart'
    .then (data)->
      controller.set 'colors', data.colors
      controller.set 'order', data.order

  afterModel: (model, transition)->
    controller = @controllerFor('custom')
    if model.get('noProduct')
      controller.set 'builderStep', 1

  actions:
    error: ->
      @transitionTo('custom_shop')
    setCustomProduct: (product)->
      customItem = @modelFor('custom')
      customItem.set('product_id', product.get('id'))
      customItem.reloadRelationships()
