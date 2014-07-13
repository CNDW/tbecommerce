Trashbags.CarouselThumbnailComponent = Em.Component.extend
  tagName: 'li'
  classNameBindings: ['isActive:active']
  layout: Ember.Handlebars.compile "<img {{bind-attr src='mini_url'}}/>{{yield}}"
  isActive: (->
    @get('activeIndex') is @get('index')
    ).property('activeIndex')
  click: ->
    @sendAction('action', @get('index'))