App.CustomItem = DS.Model.extend
  name: DS.attr 'string', {defaultValue: 'custom item'}
  noProduct: Em.computed.empty 'product'
  noSelectedColors: Em.computed.empty 'selectedColors'
  colorOptions: Em.computed.alias 'product.colorTypes'

  selectedColors: DS.hasMany 'selected_color'

  completedSteps: (->
    first = !@get('noProduct')
    second = false
    third = true
    steps = [first, second, third]
  ).property('noProduct')

  stepIndex: (->
    index = 0
    @get('completedSteps').every (completed, step)->
      if (completed)
        index = step + 1
        return false
    return index
  ).property('completedSteps')

  product_id: DS.attr 'number'
  product: (->
    if @get('product_id')
      @store.find 'product', @get 'product_id'
    else
      null
    ).property('product_id')

  #- Properties for mapping SVG data
  availableColors: (->
    @store.find 'color_value'
    ).property()
  patterns: Em.computed.map 'availableColors', (color)->
    {url: color.get('small_url'), name: "#{color.get('name')}-pattern"}


App.SelectedColor = DS.Model.extend
  name: DS.attr 'string'
  swatch: DS.attr 'string'
  selector: DS.attr 'string'




#=============================================================
# Adapters and Serializers
#=============================================================


