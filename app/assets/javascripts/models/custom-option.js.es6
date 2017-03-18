App.CustomOption = DS.Model.extend({
  selected: DS.attr('boolean'),
  customItem: DS.belongsTo('custom-item'),

  name: Em.computed.alias('optionValue.name'),
  description: Em.computed.alias('optionValue.description'),
  price: DS.attr('number'),
  presentation: Em.computed.alias('optionValue.presentation'),
  largeUrl: Em.computed.alias('optionValue.largeUrl'),

  position: DS.attr('number', {defaultValue: 0}),

  optionValueId: DS.attr('number'),
  optionValue: Em.computed('optionValueId', function() {
    if (this.get('optionValueId')) {
      return this.store.peekRecord('optionValue', this.get('optionValueId'));
    }
  })
});
