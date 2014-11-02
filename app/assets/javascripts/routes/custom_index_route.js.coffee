App.CustomItemRoute = Em.Route.extend()
  # beforeModel: ->
  #   debugger
  # model: ->
  #   store = @store
  #   model = {}
  #   items = store.all('custom_item').filterBy('inShop', true);
  #   if (items.get 'length')
  #     model = items[0]
  #   else
  #     item = store.createRecord 'custom_item',
  #       inShop: true
  #     model = item
  # afterModel: ->
  #   debugger

App.CustomIndexRoute = App.CustomItemRoute.extend()
