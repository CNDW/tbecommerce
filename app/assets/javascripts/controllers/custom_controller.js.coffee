App.CustomController = Em.ObjectController.extend
  product: Em.computed.alias 'model.product'
  noProduct: Em.computed.alias 'model.noProduct'
  price: Em.computed.alias 'model.price'
  products: Em.computed ->
    @store.all 'product'

  category_list: Em.computed 'products', ->
    @get('products').mapBy('category').uniq()

  selectedColors: Em.computed.alias 'model.selectedColors'
  categories: Em.computed.map 'category_list', (category)->
    self = this
    models = @get('products').filterBy 'category', category
    return_category =
      name: category
      types: models.mapBy('product_type').uniq().map (type)->
        items = self.get('products').filterBy('product_type', type)
        prices = items.mapBy 'price'
        name: type
        items: items.sortBy 'price'
        average_price: (items.mapBy('price').reduce((sum, add)->
          sum + add
        , 0) / items.length)
      .sortBy 'average_price'


  featuredItems: Em.computed 'products', ->
    @get('products').filterBy 'featured', true
  colors: Em.A()
  options: Em.computed.alias 'model.customOptions'
  builderStep: 1
  isStepOne: Em.computed.equal 'builderStep', 1
  isStepTwo: Em.computed.equal 'builderStep', 2
  isStepThree: Em.computed.equal 'builderStep', 3
  isStepFour: Em.computed.equal 'builderStep', 4



  actions:
    transitionStep: (targetStep)->
      if (@get('model.completedStep') < targetStep - 1) or (targetStep is @get('builderStep'))
        return
      console.log "tansitionStep: #{targetStep}"
      @set 'builderStep', targetStep
      return false

    selectColor: (color, selection)->
      selection.setColor(color)
      return false

    clickOption: (selection)->
      selection.toggleProperty('selected')
      return false
