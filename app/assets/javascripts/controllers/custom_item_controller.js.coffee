App.CustomItemController = Em.ObjectController.extend
  needs: ['custom']
  featuredItems: Em.computed.alias 'controllers.custom.featuredItems'
  element_id: (->
    "custom-item-#{this.get('model.id')}"
  ).property('model.id')
  fills: (->
    colors = @get 'model.selectedColors'
    colors.map (color)->
      if not color.get('isUnselected')
        ".#{color.get('selector')}{fill:url(##{color.get('name')}-pattern)}"
      else
        ""
  ).property()

  patterns: Em.computed.alias 'model.patterns'

  selectedColors: Em.computed.alias 'model.selectedColors'
    # ".primary{fill:url(#red-pattern)}"
