App.CustomController = Em.ObjectController.extend
  product: Em.computed.alias 'model.product'
  noProduct: Em.computed.alias 'model.noProduct'
  price: Em.computed.alias 'model.price'

  selectedColors: Em.A()
  categories: Em.A()
  colors: Em.A()
  options: Em.A()
  featuredItems: Em.A()
  builderStep: 1
  isStepOne: Em.computed.equal 'builderStep', 1
  isStepTwo: Em.computed.equal 'builderStep', 2
  isStepThree: Em.computed.equal 'builderStep', 3
  isStepFour: Em.computed.equal 'builderStep', 4
  fills: Em.A()

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
      if (@get('model.completedStep') < targetStep - 1) or (targetStep is @get('builderStep'))
        return
      console.log "tansitionStep: #{targetStep}"
      @set 'builderStep', targetStep
      return false

    selectColor: (color, selection)->
      selection.setColor(color)
      @setFills()
      return false

    clickOption: (selection)->
      selection.toggleProperty('selected')
      return false
