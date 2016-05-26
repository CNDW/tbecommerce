App.SelectedColor = DS.Model.extend
  name: DS.attr 'string'
  title: Em.computed.alias 'colorType.presentation'
  swatch: DS.attr 'string'
  selector: DS.attr 'string'
  colors: Em.computed.alias 'colorType.colorValues'
  customItem: DS.belongsTo 'custom_item'

  isSelected: Em.computed.notEmpty 'colorValue_id'

  position: Em.computed 'colorType_id', ->
    @get 'colorType.position'

  line_color: Em.computed 'colorType_id', ->
    @get 'colorType.line_color'

  #- Design pattern for DS.hasOne pointing to resources not saved in localStorage
  colorType_id: DS.attr 'number', defaultValue: null
  colorType: Em.computed 'colorType_id', ->
    if @get 'colorType_id'
      @store.findRecord 'color_type', @get 'colorType_id'

  colorValue_id: DS.attr 'number', defaultValue: null
  colorValue: Em.computed 'colorType_id', ->
    if @get 'colorValue_id'
      @store.findRecord 'color_value', @get 'colorValue_id'

  #- Helper methods
  setColor: (colorValue)->
    @set 'colorValue_id', colorValue.get('id')
    @set 'name', colorValue.get('name')
    @set 'swatch', colorValue.get('small_url')
    @set 'selector', @get('colorType.selector')
    @get('customItem').save()
