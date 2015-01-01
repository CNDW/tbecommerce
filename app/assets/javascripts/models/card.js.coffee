App.Card = DS.Model.extend
  number: DS.attr 'string'
  exp_month: DS.attr 'number'
  exp_year: DS.attr 'number'
  cvc: DS.attr 'string'

  object: DS.attr 'string'
  brand: DS.attr 'string'
  funding: DS.attr 'string'
  token: DS.attr 'string', defaultValue: null
  hasToken: Em.computed.notEmpty 'token'
  used: DS.attr 'boolean', defaultValue: false

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

  createToken: (order)->
    self = this
    return new Em.RSVP.Promise (resolve, reject)->
      if self.get 'hasToken'
        resolve()
      else
        self.validateCardAttrs().then ->
          Stripe.card.createToken
            number: self.get 'number'
            cvc: self.get 'cvc'
            exp_month: self.get 'exp_month'
            exp_year: self.get 'exp_year'
            name: order.get 'bill_address.fullname'
            address_line1: order.get 'bill_address.address1'
            address_line2: order.get 'bill_address.address2'
            address_city: order.get 'bill_address.city'
            address_state: order.get 'bill_address.state_abbr'
            address_zip: order.get 'bill_address.zipcode'
            address_country: order.get 'bill_address.country_name '
          , (status, response)->
            if response.error
              alert response.error.message
              reject()
            else
              self.setCardAttrs(response)
              resolve()
        , ->
          alert 'Invalid Card Information, Please check your information and try again'
          reject()

  stripeResponseHandler: (status, response)->
    if response.error
      alert(response.error.message)
    else
      @setCardAttrs(response)

  setCardAttrs: (data)->
    @setProperties data.card
    @set 'token', data.id
    @set 'number', data.card.last4
    @set 'created', data.created
    @set 'object', data.object
    @set 'used', data.used
    @save()

  validateCardAttrs: ->
    self = this
    return new Em.RSVP.Promise (resolve, reject)->
      validCard = Stripe.card.validateCardNumber(self.get('number'))
      validCVC = Stripe.card.validateCVC(self.get('cvc'))
      if (validCard && validCVC)
        resolve(validCard)
      else
        reject('Invalid Card')

  clearData: ->
    @set 'token', null
    @set 'number', ''
