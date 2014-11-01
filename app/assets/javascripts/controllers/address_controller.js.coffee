App.AddressController = Em.ObjectController.extend
  name: (->
    "#{@get 'model.fullname'}"
  ).property('model.fullname')
  street_address: (->
    "#{@get 'model.address1'}\n#{@get 'model.address2'}"
  ).property('model.address1', 'model.address2')
  city: (->
    if @get('states_required')
      "#{@get 'model.city'}, #{@get 'model.state_abbr'} #{@get 'model.zipcode'}"
    else
      "#{@get 'model.city'}, #{@get 'model.zipcode'}"
  ).property('model.city', 'model.state_abbr', 'model.zipcode', 'model.states_required')
  country: (->
    "#{@get 'model.country_name'}"
  ).property('model.country_name')
  email: (->
    "#{@get 'model.email'}"
  ).property('model.email')
  phone: (->
    "#{@get 'model.phone'}"
  ).property('model.phone')

  address_attributes: Em.computed.collect 'name', 'street_address', 'city', 'country', 'email', 'phone'