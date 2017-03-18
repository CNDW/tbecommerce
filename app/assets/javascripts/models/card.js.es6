/* global Stripe */
let self;
App.Card = DS.Model.extend({
  number: DS.attr('string'),
  expMonth: DS.attr('number'),
  expYear: DS.attr('number'),
  cvc: DS.attr('string'),

  object: DS.attr('string'),
  brand: DS.attr('string'),
  funding: DS.attr('string'),
  token: DS.attr('string', {defaultValue: null}),
  hasToken: Em.computed.notEmpty('token'),
  used: DS.attr('boolean', {defaultValue: false}),

  created: DS.attr('number', {defaultValue: null}),
  livemode: DS.attr('boolean'),
  type: DS.attr('string'),

  name: DS.attr('string'),
  addressLine1: DS.attr('string'),
  addressLine2: DS.attr('string'),
  addressCity: DS.attr('string'),
  addressState: DS.attr('string'),
  addressZip: DS.attr('string'),
  addressCountry: DS.attr('string'),

  isCreated: Em.computed.notEmpty('created'),

  createToken(order) {
    self = this;
    return new Em.RSVP.Promise(function(resolve, reject) {
      if (self.get('hasToken')) {
        return resolve();
      } else {
        return self.validateCardAttrs().then(function() {
          return Stripe.card.createToken({
            number: self.get('number'),
            cvc: self.get('cvc'),
            exp_month: self.get('expMonth'),
            exp_year: self.get('expYear'),
            name: order.get('billAddress.fullname'),
            address_line1: order.get('billAddress.address1'),
            address_line2: order.get('billAddress.address2'),
            address_city: order.get('billAddress.city'),
            address_state: order.get('billAddress.state_abbr'),
            address_zip: order.get('billAddress.zipcode'),
            address_country: order.get('billAddress.countryName')
          }, function(status, response) {
            if (response.error) {
              alert(response.error.message);
              return reject();
            } else {
              self.setCardAttrs(response);
              return resolve();
            }
          });
        }, function() {
          alert('Invalid Card Information, Please check your information and try again');
          return reject();
        });
      }
    });
  },

  stripeResponseHandler(status, response) {
    if (response.error) {
      return alert(response.error.message);
    } else {
      return this.setCardAttrs(response);
    }
  },

  setCardAttrs(data) {
    this.setProperties(data.card);
    this.set('token', data.id);
    this.set('number', data.card.last4);
    this.set('created', data.created);
    this.set('object', data.object);
    this.set('used', data.used);
    return this.save();
  },

  validateCardAttrs() {
    let self = this;
    return new Em.RSVP.Promise(function(resolve, reject) {
      let validCard = Stripe.card.validateCardNumber(self.get('number'));
      let validCVC = Stripe.card.validateCVC(self.get('cvc'));
      if (validCard && validCVC) {
        return resolve(validCard);
      } else {
        return reject('Invalid Card');
      }
    });
  },

  clearData() {
    this.set('token', null);
    return this.set('number', '');
  }
});
