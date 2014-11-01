App.RadioButtonComponent = Em.Component.extend
  tagName: 'input'
  type: 'radio'
  attributeBindings: ['type', 'htmlChecked:checked', 'value', 'name']
  htmlChecked: (->
    @get('value') == @get('checked')
  ).property('value', 'checked')
  change: ->
    @set('checked', @get('value'))