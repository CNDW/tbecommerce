App.CarouselController = Em.ArrayController.extend
  init: ->
    @cycleCarousel()
    @_super()
  currentContentDidChange: (->
    @set('slideIndex', 0)
    ).observes('model')
  slideIndex: 0
  thumbnails: (->
    self = @
    @model.map (item, index)->
      {
        'index':index
        'mini_url':item.get('thumb_url')
        'activeIndex': self.get('slideIndex')
      }
    ).property('model', 'slideIndex')
  activeSlide: (->
    @model.objectAt(@slideIndex)
    ).property('model', 'slideIndex')
  nextSlide: ->
    if (@slideIndex < @get('length') - 1)
      @incrementProperty 'slideIndex'
    else
      @set('slideIndex', 0)
  previousSlide: ->
    if (@slideIndex > 0)
      @decrementProperty 'slideIndex'
    else
      @set('slideIndex', @get('length') - 1)
  cycleCarousel: ->
    @slide_show = setInterval($.proxy(@nextSlide, @), 5000)
  stopCycle: ->
    clearInterval @slide_show
  willDestroy: ->
    clearInterval @slide_show
  actions:
    setSlide: (newIndex)->
      @stopCycle()
      @set('slideIndex', newIndex)
      @cycleCarousel()