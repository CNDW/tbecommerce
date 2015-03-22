App.CarouselThumbnailComponent = Em.Component.extend
  classNameBindings: ['isActive:active']
  layout: Ember.HTMLBars.compile "<img {{bind-attr src='mini_url'}}/>{{yield}}"
  isActive: (->
    @get('activeIndex') is @get('index')
    ).property('activeIndex')
  click: ->
    @sendAction('action', @get('index'))