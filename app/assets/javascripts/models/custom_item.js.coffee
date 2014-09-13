App.CustomItem = DS.Model.extend
  name: DS.attr 'string', {defaultValue: 'custom item'}

  noProduct: Em.computed.empty 'product'

App.CustomItemAdapter = DS.LSAdapter.extend()
App.CustomItemSerializer = DS.LSSerializer.extend()