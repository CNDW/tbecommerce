App.ActiveMockView = Em.View.extend
  layout: Em.Handlebars.compile "<div class='active-mock'> </div>"
  didInsertElement: ->
    @insertSVG()
    @setPatterns()
    @renderColors()

  renderColors: ->
    colors = @get('controller.model.selectedColors')
    colors.forEach (color)->
      @$(".#{color.get('selector')}").css('fill', "url(##{color.get('name')}-pattern)")
    , this

  setPatterns: ->
    patterns = @get('controller.model.patterns').join()
    @$('defs').html(patterns)

  insertSVG: ->
    svg = @get('controller.model.svg_data')
    @$('.active-mock').html(svg)