App.OrderAdapter = DS.ActiveModelAdapter.extend
  namespace: 'api'


App.OrderSerializer = DS.ActiveModelSerializer.extend DS.EmbeddedRecordsMixin,
  attrs:
    bill_address: embedded: 'always'
    ship_address: embedded: 'always'
    line_items: embedded: 'always'