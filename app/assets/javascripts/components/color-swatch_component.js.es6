App.ColorSwatchComponent = Em.Component.extend({
  classNameBindings: ['isSelected:active'],
  classNames: 'color-swatch',
  layout: Em.HTMLBars.compile("<img class='img-responsive' src={{image}}/>{{yield}}"),
  image: Em.computed.alias('model.thumbUrl'),
  isSelected: Em.computed('selection.colorValueId', function() {
    return this.get('selection.colorValueId') === this.get('model.id');
  }),

  click() {
    this.get('selectColor')(this.get('model'));
  }
});
