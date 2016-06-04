App.CustomColorsController = Em.Controller.extend(App.CustomItemControllerMixin, {
  customController: Em.inject.controller('custom'),
  hasProductAndColors: Em.computed.alias('customController.hasProductAndColors'),
  colorTypes: Em.computed.sort('model.selectedColors', (a, b) => {
    return a.get('position') - b.get('position');
  }),

  actions: {
    selectColor(color, selection) {
      selection.setColor(color);
    }
  }
});
