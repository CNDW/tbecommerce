object @variant
attributes *variant_attributes

cache [I18n.locale, @current_user_roles.include?('admin'), 'big_variant', root_object]

extends "spree/api/variants/small"

node :total_on_hand do
  root_object.total_on_hand
end
