App.AddressController = Em.Controller.extend({
  name: (function() {
    return `${this.get('model.fullname')}`;
  }).property('model.fullname'),
  street_address: (function() {
    return `${this.get('model.address1')}\n${this.get('model.address2')}`;
  }).property('model.address1', 'model.address2'),
  city: (function() {
    if (this.get('states_required')) {
      return `${this.get('model.city')}, ${this.get('model.state_abbr')} ${this.get('model.zipcode')}`;
    } else {
      return `${this.get('model.city')}, ${this.get('model.zipcode')}`;
    }
  }).property('model.city', 'model.state_abbr', 'model.zipcode', 'model.states_required'),
  country: (function() {
    return `${this.get('model.country_name')}`;
  }).property('model.country_name'),
  email: (function() {
    return `${this.get('model.email')}`;
  }).property('model.email'),
  phone: (function() {
    return `${this.get('model.phone')}`;
  }).property('model.phone'),

  address_attributes: Em.computed.collect('name', 'street_address', 'city', 'country', 'email', 'phone')
});