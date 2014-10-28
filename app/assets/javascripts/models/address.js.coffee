App.Address = Ember.Mixin.create
  firstname: DS.attr 'string', defaultValue: null
  lastname: DS.attr 'string', defaultValue: null
  fullname: (->
    "#{@get 'firstname'} #{@get 'lastname'}"
  ).property('firstname', 'lastname')
  address1: DS.attr 'string', defaultValue: null
  address2: DS.attr 'string', defaultValue: null
  email: DS.attr 'string', defaultValue: null
  email_confirm: DS.attr 'string', defaultValue: null
  city: DS.attr 'string', defaultValue: null
  zipcode: DS.attr 'string', defaultValue: null
  phone: DS.attr 'string', defaultValue: null
  state_name: DS.attr 'string', defaultValue: null
  alternative_phone: DS.attr 'string', defaultValue: null
  country_id: DS.attr 'number', defaultValue: null
  country: (->
    @store.getById 'country', @get 'country_id'
  ).property('country_id')
  country_name: (->
    @get('country.name')
  ).property('country_id')
  state_id: DS.attr 'number', defaultValue: null
  state: (->
    @store.getById 'state', @get 'state_id'
  ).property('state_id')
  state_name: (->
    @get('state.name')
  ).property('state_id')
  states_required: (->
    @get('country.states_required')
  ).property('country_id')

  order: DS.belongsTo 'order'


App.ShipAddress = DS.Model.extend App.Address,
  address_name: 'ship_address'

App.BillAddress = DS.Model.extend App.Address,
  address_name: 'bill_address'