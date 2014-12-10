App.OrderAdapter = DS.ActiveModelAdapter.extend
  namespace: 'api'

App.OrderSerializer = DS.ActiveModelSerializer.extend DS.EmbeddedRecordsMixin,
  attrs:
    line_items: embedded: 'always'
    shipments: embedded: 'always'
    ship_address: embedded: 'always'
    bill_address: embedded: 'always'
    payment_methods: embedded: 'always'
    payments: embedded: 'always'

App.ShipmentSerializer = DS.ActiveModelSerializer.extend DS.EmbeddedRecordsMixin,
  attrs:
    shipping_methods: embedded: 'always'
    shipping_rates: embedded: 'always'
    selected_shipping_rate: embedded: 'always'

App.PaymentSerializer = DS.ActiveModelSerializer.extend DS.EmbeddedRecordsMixin,
  attrs:
    payment_methods: embedded: 'always'

App.LineItemAdapter = DS.ActiveModelAdapter.extend
  #dirty hack to prevent ember from sending ajax requests, line
  #  item data is being pushed from the order via backdoor ajax
  #  calls.
  find: ->
    return new Em.RSVP.Promise (resolve, reject)->
      Ember.run(null, reject, {})