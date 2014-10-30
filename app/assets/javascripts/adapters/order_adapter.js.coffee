App.OrderAdapter = DS.ActiveModelAdapter.extend
  namespace: 'api'


App.OrderSerializer = DS.ActiveModelSerializer.extend DS.EmbeddedRecordsMixin,
  attrs:
    line_items: embedded: 'always'