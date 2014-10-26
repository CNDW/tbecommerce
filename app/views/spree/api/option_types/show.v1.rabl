object @option_type
cache @option_type, expires_in: 10.minutes
attributes *option_type_attributes
attributes :product_ids
child :option_values => :option_values do
  extends 'spree/api/option_values/show'
end