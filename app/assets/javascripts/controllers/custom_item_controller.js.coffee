App.CustomItemController = Em.ObjectController.extend
  needs: ['custom']
  featuredItems: Em.computed.alias 'controllers.custom.featuredItems'

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

  mocks: Em.computed.alias 'model.product_mocks'

  active_mock: (->
    @get('mocks.firstObject')
  ).property('mocks')
    # ".primary{fill:url(#red-pattern)}"
