App.ProductOptionValue = DS.Model.extend
  name: DS.attr 'string'
  price: DS.attr 'number', {defaultValue: 0}
  description: DS.attr 'string'
  thumb_url: DS.attr 'string'
  small_url: DS.attr 'string'
  medium_url: DS.attr 'string'
  large_url: DS.attr 'string'
  presentation: DS.attr 'string'
  position: DS.attr 'number'

App.OptionValue = App.ProductOptionValue.extend()

App.ColorValue = App.ProductOptionValue.extend()