App.AddressController = Em.Controller.extend({
  name: Em.computed('model.fullname', function() {
    return `${this.get('model.fullname')}`;
  }),

  streetAddress: Em.computed('model.address1', 'model.address2', function() {
    return `${this.get('model.address1')}\n${this.get('model.address2')}`;
  }),

  city: Em.computed('model.city', 'model.stateAbbr', 'model.zipcode', 'model.statesRequired', function() {
    if (this.get('statesRequired')) {
      return `${this.get('model.city')}, ${this.get('model.stateAbbr')} ${this.get('model.zipcode')}`;
    } else {
      return `${this.get('model.city')}, ${this.get('model.zipcode')}`;
    }
  }),

  country: Em.computed('model.countryName', function() {
    return `${this.get('model.countryName')}`;
  }),

  email: Em.computed('model.email', function() {
    return `${this.get('model.email')}`;
  }),

  phone: Em.computed('model.phone', function() {
    return `${this.get('model.phone')}`;
  }),

  addressAttributes: Em.computed.collect('name', 'streetAddress', 'city', 'country', 'email', 'phone')
});
