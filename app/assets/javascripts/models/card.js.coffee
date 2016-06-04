App.Card = DS.Model.extend
  number: DS.attr 'string'
  expMonth: DS.attr 'number'
  expYear: DS.attr 'number'
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
  addressLine1: DS.attr 'string'
  addressLine2: DS.attr 'string'
  addressCity: DS.attr 'string'
  addressState: DS.attr 'string'
  addressZip: DS.attr 'string'
  addressCountry: DS.attr 'string'

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
            exp_month: self.get 'expMonth'
            exp_year: self.get 'expYear'
            name: order.get 'billAddress.fullname'
            address_line1: order.get 'billAddress.address1'
            address_line2: order.get 'billAddress.address2'
            address_city: order.get 'billAddress.city'
            address_state: order.get 'billAddress.state_abbr'
            address_zip: order.get 'billAddress.zipcode'
            address_country: order.get 'billAddress.countryName'
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
