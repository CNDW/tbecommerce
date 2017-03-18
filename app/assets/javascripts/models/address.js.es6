App.AddressMixin = Em.Mixin.create({
  firstname: DS.attr('string', {defaultValue: null}),
  lastname: DS.attr('string', {defaultValue: null}),
  fullname: Em.computed('firstname', 'lastname', function() {
    return `${this.get('firstname')} ${this.get('lastname')}`;
  }),
  address1: DS.attr('string', {defaultValue: null}),
  address2: DS.attr('string', {defaultValue: null}),
  email: DS.attr('string', {defaultValue: null}),
  city: DS.attr('string', {defaultValue: null}),
  zipcode: DS.attr('string', {defaultValue: null}),
  phone: DS.attr('string', {defaultValue: null}),
  stateName: DS.attr('string', {defaultValue: null}),
  alternativePhone: DS.attr('string', {defaultValue: null}),

  country: DS.belongsTo('country'),
  countryName: Em.computed.alias('country.name'),

  state: DS.belongsTo('state'),
  stateAbbr: Em.computed.alias('state.abbr'),

  statesRequired: Em.computed.alias('country.statesRequired'),

  order: DS.belongsTo('order'),

  clearState: Em.observer('country', function() {
    return this.set('state', null);
  }),

  getAttributes() {
      return {
        firstname: this.get('firstname'),
        lastname: this.get('lastname'),
        address1: this.get('address1'),
        address2: this.get('address2'),
        email: this.get('email'),
        city: this.get('city'),
        zipcode: this.get('zipcode'),
        phone: this.get('phone'),
        state_id: this.get('state.id'),
        country_id: this.get('country.id')
      };
    }
});


App.ShipAddress = DS.Model.extend(App.AddressMixin,
  {addressName: 'Shipping Address'});

App.BillAddress = DS.Model.extend(App.AddressMixin,
  {addressName: 'Billing Address'});
