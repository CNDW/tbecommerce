App.SelectionOptionComponent = Em.Component.extend
  classNames: 'selection-option'
  classNameBindings: 'isSelected:active'
  isSelected: (->
    @get('custom_item.hasProduct') and (@get('custom_item.product_id').toString() is @get('item.id').toString())
  ).property('custom_item.product_id')
  click: ->
    @sendAction 'action', @get('item')
