App.CustomItemView = Em.View.extend
  templateName: 'tmp-svg'
  didInsertElement: ->
    @renderColors()

  renderColors: ->
    colors = @get('controller.model.selectedColors')
    colors.forEach (color)->
      @$(".#{color.get('selector')}").css('fill', "url(##{color.get('name')}-pattern)")
    , this

