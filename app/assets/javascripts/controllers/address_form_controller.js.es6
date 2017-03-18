App.AddressFormController = Em.Controller.extend({
  countries: Em.computed(function() {
    return this.store.all('country').map((country) => {
      return {
        name: country.get('name'),
        id: country,
        css: 'country-name'
      };
    });
  }),
  states: Em.computed('model.country', function() {
    return this.model.get('country.states').map((state) => {
      return {
        name: state.get('name'),
        id: state,
        css: 'state-name'
      };
    });
  })
});
