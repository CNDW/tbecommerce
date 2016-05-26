App.CustomShopRoute = Em.Route.extend
  model: ->
    store = @store
    model = {}
    items = store.findAll('custom_item').filterBy('inShop', true);
    if Em.isEmpty(items)
      item = store.createRecord 'custom_item',
        inShop: true
        shop_state: 'new'
      item.save()
      model = item
    else
      model = items.get('firstObject')
  afterModel: (model, transition)->
    @transitionTo 'custom', model
