App.ToggleMenuComponent = Em.Component.extend
  isShowing: false
  classNameBindings: 'isShowing:active'

  click: ->
    @toggleProperty 'isShowing'