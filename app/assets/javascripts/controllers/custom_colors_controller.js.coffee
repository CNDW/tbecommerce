App.CustomColorsController = Em.ObjectController.extend
  colors: Em.computed ->
    @store.all 'color_value'

  actions:
    selectColor: (color, selection)->
      selection.setColor(color)
      return false