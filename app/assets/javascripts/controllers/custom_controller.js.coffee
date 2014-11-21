App.CustomController = Em.ObjectController.extend
  product: Em.computed.alias 'model.product'
  hasProduct: Em.computed.alias 'model.hasProduct'
  price: Em.computed.alias 'model.price'
  products: Em.computed ->
    @store.all 'product'
  featuredItems: Em.computed 'products', ->
    @get('products').filterBy 'featured', true

  selectedColors: Em.computed.alias 'model.selectedColors'

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
