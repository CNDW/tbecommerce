App.ShipmentController = Em.ObjectController.extend
  radio_name: Em.computed ->
    "shipment-radio-#{@get('model.id')}"