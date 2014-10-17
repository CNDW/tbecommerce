App.CustomItemController = Em.ObjectController.extend
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
