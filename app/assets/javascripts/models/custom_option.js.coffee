App.CustomOption = DS.Model.extend
  customItem: DS.belongsTo 'custom_item'
  selected: DS.attr 'boolean'

  name: Em.computed.alias 'optionValue.name'
  description: Em.computed.alias 'optionValue.description'
  price: DS.attr 'number'
  presentation: Em.computed.alias 'optionValue.presentation'

  saveOnChange: (->
    @get('customItem').recalculatePrice()
    @save()
  ).observes('selected')

  optionValue_id: DS.attr 'number'
  optionValue: (->
    if @get 'optionValue_id'
      @store.getById 'option_value', @get 'optionValue_id'
  ).property('optionValue_id')