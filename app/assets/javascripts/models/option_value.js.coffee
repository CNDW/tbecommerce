App.OptionValue = DS.Model.extend
  price: DS.attr('number')
  description: DS.attr('string')
  thumb_url: DS.attr('string')
  medium_url: DS.attr('string')
  large_url: DS.attr('string')

  type: DS.belongsTo('option_type')