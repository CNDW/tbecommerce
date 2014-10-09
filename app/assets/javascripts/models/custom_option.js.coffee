App.CustomOption = DS.Model.extend
  customItem: DS.belongsTo 'custom_item'
  selected: DS.attr 'boolean'

  optionValue_id: DS.attr 'number'
  optionValue: (->
    if @get 'optionValue_id'
      @store.find 'option_value', @get 'optionValue_id'
  ).property('optionValue_id')