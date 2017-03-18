App.ProductValueMixin = Em.Mixin.create({
  name: DS.attr('string'),
  price: DS.attr('number', {defaultValue: 0}),
  description: DS.attr('string'),
  thumbUrl: DS.attr('string'),
  smallUrl: DS.attr('string'),
  mediumUrl: DS.attr('string'),
  largeUrl: DS.attr('string'),
  presentation: DS.attr('string'),
  position: DS.attr('number', {defaultValue: 0})
});

App.OptionValue = DS.Model.extend(App.ProductValueMixin, {
  optionTypeId: DS.attr('string')
});

App.ColorValue = DS.Model.extend(App.ProductValueMixin);
