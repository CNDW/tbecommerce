App.SelectedColorController = Em.Controller.extend
  isSelected: Em.computed.alias 'model.isSelected'
  colors: Em.computed.sort 'model.colors', (a, b)->
    a.get('position') - b.get('position')
