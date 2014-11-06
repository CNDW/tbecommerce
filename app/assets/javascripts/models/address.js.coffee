App.AddressMixin = Ember.Mixin.create
  firstname: DS.attr 'string', defaultValue: null
  lastname: DS.attr 'string', defaultValue: null
  fullname: (->
    "#{@get 'firstname'} #{@get 'lastname'}"
  ).property('firstname', 'lastname')
  address1: DS.attr 'string', defaultValue: null
  address2: DS.attr 'string', defaultValue: null
  email: DS.attr 'string', defaultValue: null
  city: DS.attr 'string', defaultValue: null
  zipcode: DS.attr 'string', defaultValue: null
  phone: DS.attr 'string', defaultValue: null
  state_name: DS.attr 'string', defaultValue: null
  alternative_phone: DS.attr 'string', defaultValue: null

  country: DS.belongsTo 'country'
  country_name: Em.computed.alias 'country.name'

  state: DS.belongsTo 'state'
  state_abbr: Em.computed.alias 'state.abbr'

  states_required: Em.computed.alias 'country.states_required'

  order: DS.belongsTo 'order'

  clearState: (->
    @set('state', null)
  ).observes('country')

  getAttributes: ->
      firstname: @get 'firstname'
      lastname: @get 'lastname'
      address1: @get 'address1'
      address2: @get 'address2'
      email: @get 'email'
      city: @get 'city'
      zipcode: @get 'zipcode'
      phone: @get 'phone'
      state_id: @get 'state.id'
      country_id: @get 'country.id'


App.ShipAddress = DS.Model.extend App.AddressMixin,
  address_name: 'Shipping Address'

App.BillAddress = DS.Model.extend App.AddressMixin,
  address_name: 'Billing Address'