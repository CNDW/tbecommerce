App.CustomItem = DS.Model.extend
  name: DS.attr 'string'

App.CustomItemAdapter = DS.LSAdapter.extend()
App.CustomItemSerializer = DS.LSSerializer.extend()