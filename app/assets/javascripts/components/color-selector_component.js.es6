App.ColorSelectorComponent = Em.Component.extend({
  isSelected: Em.computed.alias('model.isSelected'),

  colors: Em.computed.sort('model.colors', (a, b) => {
    return a.get('position') - b.get('position');
  }),

  actions: {
    selectColor(color) {
      this.get('model').selectColor(color);
    }
  }
});
