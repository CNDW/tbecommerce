App.CartController = Em.ObjectController.extend
  subtotal: (->
    base = 0
    @model.get('line_items').forEach (line_item)->
      base += line_item.get('price')
    return base
  ).property('model.length')