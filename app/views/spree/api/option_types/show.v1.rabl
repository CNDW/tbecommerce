object @option_type
attributes *option_type_attributes
attributes :product_ids
child :option_values => :option_values do
  attributes *option_value_attributes
end