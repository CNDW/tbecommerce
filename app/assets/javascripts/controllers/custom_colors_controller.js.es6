App.CustomColorsController = Em.Controller.extend(App.CustomItemControllerMixin, {
  needs: ['custom'],
  hasProductAndColors: Em.computed.alias('controllers.custom.hasProductAndColors'),
  color_types: Em.computed.sort('model.selectedColors', (a, b)=> a.get('position') - b.get('position')),

  actions: {
    selectColor(color, selection){
      selection.setColor(color);
      return false;
    }
  }
});
