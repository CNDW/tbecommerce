App.ProductOptionType = DS.Model.extend
  name: DS.attr 'string'
  presentation: DS.attr 'string'
  position: DS.attr 'number'
  description: DS.attr 'string'
  required: DS.attr 'boolean'
  catalogue: DS.attr 'boolean'
  thumb_url: DS.attr 'string'
  medium_url: DS.attr 'string'
  large_url: DS.attr 'string'

App.OptionType = App.ProductOptionType.extend
  optionValues: DS.hasMany 'option_value'

App.ColorType = App.ProductOptionType.extend
  colorValues: DS.hasMany 'color_value'