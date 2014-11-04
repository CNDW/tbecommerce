App.Card = DS.Model.extend
  number: DS.attr 'string'
  exp_month: DS.attr 'string'
  exp_year: DS.attr 'string'
  cvc: DS.attr 'string'

  object: DS.attr 'string'
  brand: DS.attr 'string'
  funding: DS.attr 'string'
  token: DS.attr 'string', defaultValue: null
  used: DS.attr 'boolean'

  created: DS.attr 'number', defaultValue: null
  livemode: DS.attr 'boolean'
  type: DS.attr 'string'

  name: DS.attr 'string'
  address_line1: DS.attr 'string'
  address_line2: DS.attr 'string'
  address_city: DS.attr 'string'
  address_state: DS.attr 'string'
  address_zip: DS.attr 'string'
  address_country: DS.attr 'string'

  isCreated: Em.computed.notEmpty 'created'

  createToken: ->
    Stripe.card.createToken
      number: @get 'number'
      cvc: @get 'cvc'
      exp_month: @get 'exp_month'
      exp_year: @get 'exp_year'
      name: @get 'name'
      address_line1: @get 'address_line1'
      address_line2: @get 'address_line2'
      address_city: @get 'address_city'
      address_state: @get 'address_state'
      address_zip: @get 'address_zip'
      address_country: @get 'address_country'
    , @stripeResponseHandler

  stripeResponseHandler: (status, resonse)->
    if response.error
      alert(response.error.message)
    else
      @setCardAttrs(response)

  setCardAttrs: (data)->
    @setProperties data.card
    @set token, data.id
    @set number, data.card.last4
    @set created, data.created
    @set object, data.object
    @set used, data.used
    @save()

