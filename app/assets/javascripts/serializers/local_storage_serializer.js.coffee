App.LSAdapterMixin = Em.Mixin.create
  namespace: 'TrashBags'

App.CustomItemAdapter = DS.LSAdapter.extend App.LSAdapterMixin
App.CustomItemSerializer = DS.LSSerializer.extend()

App.SelectedColorAdapter = DS.LSAdapter.extend App.LSAdapterMixin
App.SelectedColorSerializer = DS.LSSerializer.extend()

App.CustomOptionAdapter = DS.LSAdapter.extend App.LSAdapterMixin
App.CustomOptionSerializer = DS.LSSerializer.extend()

App.CartAdapter = DS.LSAdapter.extend App.LSAdapterMixin
App.CartSerializer = DS.LSSerializer.extend()