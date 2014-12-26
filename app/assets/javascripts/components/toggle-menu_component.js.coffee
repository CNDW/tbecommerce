App.ToggleMenuComponent = Em.Component.extend Em.Evented,
  isShowing: false
  classNameBindings: 'isShowing:active'

  didInsertElement: ->
    App.EventBus.on 'collapseMenus', this, @collapseMenu

  collapseMenu: ->
    @set 'isShowing', false
  click: ->
    App.EventBus.trigger('collapseMenus') unless @get('isShowing')
    @toggleProperty 'isShowing'