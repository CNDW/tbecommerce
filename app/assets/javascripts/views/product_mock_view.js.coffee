App.ActiveMockView = Em.View.extend
  layout: Em.Handlebars.compile "<div class='active-mock'> </div>"
  didInsertElement: ->
    @insertSVG()
    @get('controller').on('colorsDidChange', this, this.renderColors)

  willClearRender: ->
    @get('controller').on('colorsDidChange', this, this.renderColors)

  renderColors: ->
    colors = @get('controller.model.selectedColors')
    colors.forEach (color)->
      @$(".#{color.get('selector')}").css('fill', "url(##{color.get('name')}-pattern)")
    , this

  setPatterns: ->
    patterns = @get('controller.model.patterns').join()
    @$('defs').html(patterns)

  insertSVG: ->
    self = this
    mock = @get('controller.active_mock')
    mock.getSvg().then (svg)->
      self.$('.active-mock').html(svg)
      self.setPatterns()
      self.renderColors()