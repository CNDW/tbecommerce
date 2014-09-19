App.ColorSwatchComponent = Em.Component.extend
  classNameBindings: ['isSelected:active']
  classNames: 'color-swatch'
  layout: Ember.Handlebars.compile "<img class='img-responsive' {{bind-attr src='image'}}/>{{yield}}"
  isSelected: (->
    @get('color.selectedColor.id') is @get('swatch.id')
    ).property('color.selectedColor')
  click: ->
    @sendAction('action', @get('swatch'), @get('color'))