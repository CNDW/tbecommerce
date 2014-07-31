Trashbags.OptionType = DS.Model.extend
  name: DS.attr('string')
  presentation: DS.attr('string')
  position: DS.attr('number')
  description: DS.attr('string')
  required: DS.attr('boolean')
  catalogue: DS.attr('boolean')

  values: DS.hasMany('option_value')