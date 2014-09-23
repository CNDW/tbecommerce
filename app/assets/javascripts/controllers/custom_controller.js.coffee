App.CustomController = Em.ObjectController.extend
  product: Em.computed.alias 'model.product'
  noProduct: Em.computed.alias 'model.noProduct'
  selectedColors: []
  builderStep: 1
  isStepOne: Em.computed.equal 'builderStep', 1
  isStepTwo: Em.computed.equal 'builderStep', 2
  isStepThree: Em.computed.equal 'builderStep', 3
  isStepFour: Em.computed.equal 'builderStep', 4
  fills: []

  setFills: ()->
    fills = @get('selectedColors').map (color)->
      if not color.get('isUnselected')
        name = color.get 'name'
        selector = color.get 'selector'
        x = ".#{selector}{fill:url(##{name}-pattern)}"
      else
        ""
    @set 'fills', fills

  actions:
    transitionStep: (targetStep)->
      console.log "tansitionStep: #{targetStep}"
      return if targetStep is @get('builderStep')
      @set 'builderStep', targetStep
