object @country
cache @country, expires_in: 1.day
attributes *country_attributes
child :states => :states do
  extends "spree/api/states/show"
end