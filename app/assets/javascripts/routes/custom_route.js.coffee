App.CustomRoute = Em.Route.extend

  setupController: (controller, model)->
    @_super controller, model
    Em.RSVP.hash
      colors: @store.all 'color_value'
      order: @modelFor 'cart'
    .then (data)->
      controller.set 'colors', data.colors
      controller.set 'order', data.order

  afterModel: (model, transition)->
    controller = @controllerFor('custom')
    if !model.get('hasProduct')
      controller.set 'builderStep', 1

  actions:
    error: ->
      @transitionTo('custom_shop')
