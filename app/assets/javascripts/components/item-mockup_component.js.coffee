App.ItemMockupComponent = Em.Component.extend
  template: Ember.Handlebars.compile "{{partial 'tmp-svg'}}"
  # willInsertElement: ->
  #   @set 'selectedColors', @get 'item.selectedColors'
  fills: Em.computed.map 'selectedColors', (color)->
      if not color.get('isUnselected')
        name = color.get 'name'
        selector = color.get 'selector'
        ".#{selector}{fill:url(##{name}-pattern)}"
      else
        ''
  # setFills: ->
  #   console.log('setFills')
  #   fills = @get('selectedColors.content').map (color)->
  #     if not color.get('isUnselected')
  #       name = color.get 'name'
  #       selector = color.get 'selector'
  #       ".#{selector}{fill:url(##{name}-pattern)}"
  #     else
  #       ''
  #   @set 'fills', fills