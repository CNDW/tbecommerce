App.ColorSwatchComponent = Em.Component.extend({
  classNameBindings: ['isSelected:active'],
  classNames: 'color-swatch',
  layout: Em.HTMLBars.compile("<img class='img-responsive' src={{image}}/>{{yield}}"),
  isSelected: Em.computed('selection.colorValueId', function() {
    return this.get('selection.colorValueId') === this.get('color.id');
  }),

  click() {
    return this.sendAction('action', this.get('color'), this.get('selection'));
  }
});
