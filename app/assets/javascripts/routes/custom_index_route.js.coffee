App.CustomIndexRoute = Em.Route.extend
  afterModel: (model, transition)->
    state = model.get 'shop_state'
    switch state
      when 'new' then @transitionTo 'custom.product'
      when 'colors' then @transitionTo 'custom.colors'
      when 'options' then @transitionTo 'custom.options'
      when 'extras' then @transitionTo 'custom.extras'
      when 'complete' then @transitionTo 'custom.extras'
      else @transitionTo 'custom.product'