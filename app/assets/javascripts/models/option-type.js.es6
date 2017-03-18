App.ProductOptionMixin = Em.Mixin.create({
  name: DS.attr('string'),
  presentation: DS.attr('string'),
  position: DS.attr('number', {defaultValue: 0})
});

App.OptionType = DS.Model.extend(App.ProductOptionMixin, {
  optionValues: DS.hasMany('option-value'),
  description: DS.attr('string'),
  required: DS.attr('boolean'),
  catalogue: DS.attr('boolean'),
  thumbUrl: DS.attr('string'),
  mediumUrl: DS.attr('string'),
  largeUrl: DS.attr('string'),
  products: DS.hasMany('product')
});

App.ColorType = DS.Model.extend(App.ProductOptionMixin, {
  selector: DS.attr('string'),
  colorValues: DS.hasMany('color-value'),
  lineColor: DS.attr('boolean')
});
