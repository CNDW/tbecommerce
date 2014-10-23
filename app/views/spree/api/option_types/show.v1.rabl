object @option_type
cache [I18n.locale, root_object]
attributes *option_type_attributes
attributes :product_ids
child :option_values => :option_values do
  extends 'spree/api/option_values/show'
end