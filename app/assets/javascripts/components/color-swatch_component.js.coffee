App.ColorSwatchComponent = Em.Component.extend
  classNameBindings: ['isSelected:active']
  classNames: 'color-swatch'
  layout: Ember.Handlebars.compile "<img class='img-responsive' {{bind-attr src='image'}}/>{{yield}}"
  isSelected: (->
    @get('selection.colorValue_id') is @get('color.id')
    ).property('selection.colorValue_id')
  click: ->
    @sendAction('action', @get('color'), @get('selection'))