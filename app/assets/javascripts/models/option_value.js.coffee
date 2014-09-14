App.OptionValue = DS.Model.extend
  name: DS.attr 'string'
  price: DS.attr 'number', {defaultValue: 0}
  description: DS.attr 'string'
  thumb_url: DS.attr 'string'
  medium_url: DS.attr 'string'
  large_url: DS.attr 'string'

  optionType: DS.belongsTo 'option_type'