App.AddressFormController = Em.Controller.extend({
  countries: (function() {
    return this.store.all('country').map(country=>
      ({
        name: country.get('name'),
        id: country,
        css: 'country-name'
      })
    );
  }).property(),
  states: (function() {
    return this.model.get('country.states').map(state=>
      ({
        name: state.get('name'),
        id: state,
        css: 'state-name'
      })
    );
  }).property('model.country')
});