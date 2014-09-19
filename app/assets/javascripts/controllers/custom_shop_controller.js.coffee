App.CustomIndexController = Em.Controller.extend()
App.CustomColorsController = Em.Controller.extend
  actions:
    selectColor: (selectedColor, colorType)->
      colorType.set('selectedColor', selectedColor)
      colors = @model.get('colors') || {}
      colors[colorType.get('presentation')] = selectedColor
      @model.set('colors', colors)

