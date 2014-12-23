App.CustomController = Em.ObjectController.extend
  product: Em.computed.alias 'model.product'
  hasProduct: Em.computed.alias 'model.hasProduct'
  price: Em.computed.alias 'model.price'
  products: Em.computed ->
    @store.all('product').filter (product)->
      product.get 'in_custom_shop'
  featuredItems: Em.computed 'products', ->
    @get('products').filterBy 'featured', true

  mocks: Em.computed.alias 'model.product_mocks'

  mock_index: 0

  active_mock: (->
    @get('mocks').objectAt(@get('mock_index'))
  ).property('mocks', 'mock_index')


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
