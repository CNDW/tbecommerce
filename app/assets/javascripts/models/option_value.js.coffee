App.ProductValueMixin = Em.Mixin.create
  name: DS.attr 'string'
  price: DS.attr 'number', {defaultValue: 0}
  description: DS.attr 'string'
  thumb_url: DS.attr 'string'
  small_url: DS.attr 'string'
  medium_url: DS.attr 'string'
  large_url: DS.attr 'string'
  presentation: DS.attr 'string'

App.OptionValue = DS.Model.extend App.ProductValueMixin

App.ColorValue = DS.Model.extend App.ProductValueMixin