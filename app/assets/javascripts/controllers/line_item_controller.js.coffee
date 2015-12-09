App.LineItemController = Em.Controller.extend
  item_image: Em.computed.alias 'model.variant.catalogue_image'
  name: Em.computed.alias 'model.variant.name'