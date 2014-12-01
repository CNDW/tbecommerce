App.CustomColorsController = Em.ObjectController.extend

  color_types: Em.computed.sort 'model.selectedColors', (a, b)->
    a.get('position') - b.get('position')

  actions:
    selectColor: (color, selection)->
      selection.setColor(color)
      return false