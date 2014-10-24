App.OrderIndexController = Em.ObjectController.extend
  updateShipping: (->
    @get('model').save()
  ).observes('model.useShippingAddress')

  countries: (->
    @store.all('country').map (country)->
      {
        name: country.get('name')
        id: country.get('id')
        css: 'country-name'
      }
  ).property()
  ship_states: (->
    @model.get('ship_country.states').map (state)->
      {
        name: state.get('name')
        id: state.get('id')
        css: 'state-name'
      }
  ).property('model.ship_country_id')
  bill_states: (->
    @model.get('bill_country.states').map (state)->
      {
        name: state.get('name')
        id: state.get('id')
        css: 'state-name'
      }
  ).property('model.bill_country_id')

  actions:
    acceptChanges: ->
      @get('model').save()