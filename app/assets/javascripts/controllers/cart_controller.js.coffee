App.CartController = Em.Controller.extend
  total: Em.computed 'model.line_items.@each.total', ->
    return 0 unless @get('model.line_items')
    @get('model.line_items').reduce (prev, item)->
      prev + Number(item.get('total'))
    , 0

  display_total: Em.computed 'total', ->
    '$'+(Number(@get('total')).toFixed(2))