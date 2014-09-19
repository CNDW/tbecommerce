App.ProductOptionValue = DS.Model.extend
  name: DS.attr 'string'
  price: DS.attr 'number', {defaultValue: 0}
  description: DS.attr 'string'
  thumb_url: DS.attr 'string'
  medium_url: DS.attr 'string'
  large_url: DS.attr 'string'
  presentation: DS.attr 'string'
  position: DS.attr 'number'

App.OptionValue = App.ProductOptionValue.extend
  optionType: DS.belongsTo 'option_type'

App.ColorValue = App.ProductOptionValue.extend
  colorType: DS.belongsTo 'color_type'