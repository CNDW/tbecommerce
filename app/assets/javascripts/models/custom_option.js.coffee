App.CustomOption = DS.Model.extend
  selected: DS.attr 'boolean'
  customItem: DS.belongsTo 'custom_item'

  name: Em.computed.alias 'optionValue.name'
  description: Em.computed.alias 'optionValue.description'
  price: DS.attr 'number'
  presentation: Em.computed.alias 'optionValue.presentation'

  position: DS.attr 'number', defaultValue: 0

  optionValue_id: DS.attr 'number'
  optionValue: (->
    if @get 'optionValue_id'
      @store.getById 'option_value', @get 'optionValue_id'
  ).property('optionValue_id')