App.CartController = Em.Controller.extend
  total: Em.computed 'model.line_items.@each.total', ->
    @get('model.line_items').reduce (prev, item)->
      prev + Number(item.get('total'))
    , 0

  display_total: Em.computed 'total', ->
    '$'+@get('total')