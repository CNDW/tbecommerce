App.SelectedColor = DS.Model.extend({
  name: DS.attr('string'),
  title: Em.computed.alias('colorType.presentation'),
  swatch: DS.attr('string'),
  selector: DS.attr('string'),
  colors: Em.computed.alias('colorType.colorValues'),
  customItem: DS.belongsTo('custom-item'),

  isSelected: Em.computed.notEmpty('colorValueId'),

  position: Em.computed('colorTypeId', function() {
    return this.get('colorType.position');
  }),

  lineColor: Em.computed('colorTypeId', function() {
    return this.get('colorType.lineColor');
  }),

  //- Design pattern for DS.hasOne pointing to resources not saved in localStorage
  colorTypeId: DS.attr('number', {defaultValue: null}),
  colorType: Em.computed('colorTypeId', function() {
    if (this.get('colorTypeId')) {
      return this.store.peekRecord('colorType', this.get('colorTypeId'));
    }
  }),

  colorValueId: DS.attr('number', {defaultValue: null}),
  colorValue: Em.computed('colorTypeId', function() {
    if (this.get('colorValueId')) {
      return this.store.peekRecord('colorValue', this.get('colorValueId'));
    }
  }),

  //- Helper methods
  setColor(colorValue) {
    this.set('colorValueId', colorValue.get('id'));
    this.set('name', colorValue.get('name'));
    this.set('swatch', colorValue.get('smallUrl'));
    this.set('selector', this.get('colorType.selector'));
    return this.get('customItem').then((item) => {
      item.save();
    });
  }
});
