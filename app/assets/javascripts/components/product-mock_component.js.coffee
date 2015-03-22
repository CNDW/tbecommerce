App.ProductMockComponent = Em.Component.extend
  layout: Em.HTMLBars.compile "<div class='product-mock'> </div>"

  didInsertElement: ->
    Em.run.scheduleOnce 'afterRender', this, @insertSVG

  renderColors: ->
    return if @_state is "destroying"
    colors = @get('custom_item.selectedColors')
    colors.forEach (color)->
      if color.get('line_color')
        @$(".#{color.get('selector')}").css('stroke', "url(##{color.get('name')}-pattern)")
      else
        @$(".#{color.get('selector')}").css('fill', "url(##{color.get('name')}-pattern)")
    , this

  colorChange: (->
    Em.run.scheduleOnce 'afterRender', this, @renderColors
  ).observes('custom_item.selectedColors.@each.colorValue_id')

  setPatterns: ->
    patterns = @get('custom_item.patterns').join()
    @$('defs').html(patterns)

  insertSVG: ->
    return if @_state is "destroying"
    self = this
    mock = @get('mock')
    mock.getSvg().then (svg)->
      self.$('.product-mock').html(svg)
      self.colorChange()

  productChange: (->
    Em.run.scheduleOnce 'actions', this, @renderMock
  ).observes('mock')

  renderMock: ->
    @rerender() unless @_state is "destroying"
# custom_item, mock