App.ShipmentController = Em.Controller.extend
  needs: ['order']
  radio_name: Em.computed ->
    "shipment-radio-#{@get('model.id')}"
  order: Em.computed.alias 'controllers.order.model'
  line_items: Em.computed ->
    manifest = @get('model.manifest')
    @get('order.line_items').filter (item, index)->
      manifest.mapBy('custom_item_hash').contains(item.get('custom_item_hash'))
