App.CustomShopRoute = Em.Route.extend
  model: ->
    store = @store
    model = {}
    items = store.all('custom_item').filterBy('inShop', true);
    if Em.empty(items)
      item = store.createRecord 'custom_item',
        inShop: true
      model = item
    else
      model = items.get('firstObject')
  afterModel: (model, transition)->
    @transitionTo 'custom', model