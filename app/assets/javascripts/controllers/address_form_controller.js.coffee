App.AddressFormController = Em.Controller.extend
  countries: (->
    @store.all('country').map (country)->
      {
        name: country.get('name')
        id: country
        css: 'country-name'
      }
  ).property()
  states: (->
    @model.get('country.states').map (state)->
      {
        name: state.get('name')
        id: state
        css: 'state-name'
      }
  ).property('model.country')