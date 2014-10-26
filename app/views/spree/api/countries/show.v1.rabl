object @country
cache @country, expires_in: 1.day
attributes *country_attributes
attribute :states_required
child :states => :states do
  extends "spree/api/states/show"
end