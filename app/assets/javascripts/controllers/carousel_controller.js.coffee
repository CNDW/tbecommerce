Trashbags.CarouselController = Em.ArrayController.extend
  init: ->
    @cycleCarousel()
    @_super()
  currentContentDidChange: (->
    @set('slideIndex', 0)
    ).observes('content')
  slideIndex: 0
  thumbnails: (->
    self = @
    @content.map (item, index)->
      {
        'index':index
        'mini_url':item.get('mini_url')
        'activeIndex': self.get('slideIndex')
      }
    ).property('content', 'slideIndex')
  activeSlide: (->
    @content.objectAt(@slideIndex)
    ).property('content', 'slideIndex')
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
    Ember.run.later(@, ->
      @nextSlide()
      @cycleCarousel()
    , 5000)
  actions:
    setSlide: (newIndex)->
      @set('slideIndex', newIndex)