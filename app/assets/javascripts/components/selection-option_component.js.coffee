App.SelectionOptionComponent = Em.Component.extend
  classNames: 'selection-option'
  classNameBindings: 'isSelected:active'
  isSelected: (->
    @get('custom_item.product_id') is @get('item.id')
  ).property('custom_item.product_id')
  click: ->
    @sendAction 'action', @get('item')
