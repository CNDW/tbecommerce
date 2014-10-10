App.CustomOption = DS.Model.extend
  customItem: DS.belongsTo 'custom_item'
  selected: DS.attr 'boolean', defaultValue: false

  name: Em.computed.alias 'optionValue.name'
  description: Em.computed.alias 'optionValue.description'
  price: Em.computed.alias 'optionValue.price'
  presentation: Em.computed.alias 'optionValue.presentation'

  optionValue_id: DS.attr 'number'
  optionValue: (->
    if @get 'optionValue_id'
      @store.find 'option_value', @get 'optionValue_id'
  ).property('optionValue_id')