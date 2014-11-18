App.SelectionOptionComponent = Em.Component.extend
  classNames: 'selection-option'
  classNameBindings: 'isSelected:active'
  isSelected: (->
    if (@get('custom_item.hasProduct'))
      return (@get('custom_item.product_id').toString() is @get('item.id').toString())
    else
      return no
  ).property('custom_item.product_id')
  click: ->
    @sendAction 'action', @get('item')
