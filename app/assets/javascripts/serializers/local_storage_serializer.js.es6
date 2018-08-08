App.CustomItemAdapter = DS.LSAdapter.extend({
  namespace: 'TrashBagsCustomItem'
});
  
App.CustomItemSerializer = DS.LSSerializer.extend(DS.EmbeddedRecordsMixin, {
  attrs: {
    selectedColors: {embedded: 'always'},
    customOptions: {embedded: 'always'}
  }
});
App.SelectedColorAdapter = DS.LSAdapter.extend();
App.SelectedColorSerializer = DS.LSSerializer.extend();
App.CustomOptionAdapter = DS.LSAdapter.extend();
App.CustomOptionSerializer = DS.LSSerializer.extend();

App.CardAdapter = DS.LSAdapter.extend({
  namespace: 'TrashBagsCard'
});
App.CardSerializer = DS.LSSerializer.extend()
