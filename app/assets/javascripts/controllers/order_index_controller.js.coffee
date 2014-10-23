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

  actions:
    acceptChanges: ->
      @get('model').save()