App.SelectedColor = DS.Model.extend
  name: DS.attr 'string'
  title: Em.computed.alias 'colorType.presentation'
  swatch: DS.attr 'string'
  selector: DS.attr 'string'
  colors: Em.computed.alias 'colorType.colorValues'
  customItem: DS.belongsTo 'customItem'

  isSelected: Em.computed.notEmpty 'colorValueId'

  position: Em.computed 'colorTypeId', ->
    @get 'colorType.position'

  lineColor: Em.computed 'colorTypeId', ->
    @get 'colorType.lineColor'

  #- Design pattern for DS.hasOne pointing to resources not saved in localStorage
  colorTypeId: DS.attr 'number', defaultValue: null
  colorType: Em.computed 'colorTypeId', ->
    if @get 'colorTypeId'
      @store.findRecord 'colorType', @get 'colorTypeId'

  colorValueId: DS.attr 'number', defaultValue: null
  colorValue: Em.computed 'colorTypeId', ->
    if @get 'colorValueId'
      @store.findRecord 'colorValue', @get 'colorValueId'

  #- Helper methods
  setColor: (colorValue)->
    @set 'colorValueId', colorValue.get('id')
    @set 'name', colorValue.get('name')
    @set 'swatch', colorValue.get('smallUrl')
    @set 'selector', @get('colorType.selector')
    @get('customItem').save()
