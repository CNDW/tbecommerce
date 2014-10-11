App.CartController = Em.ArrayController.extend
  subtotal: (->
    base = 0
    @model.content.forEach (line_item)->
      base += line_item.get('price')
    return base
  ).property('model.length')