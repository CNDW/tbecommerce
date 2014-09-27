object @product
cache [I18n.locale, current_currency, root_object]
attributes *product_attributes
attributes :product_category, :product_subcategory, :specs, :tagline, :color_type_ids, :option_type_ids
node(:display_price) { |p| p.display_price.to_s }
node(:has_variants) { |p| p.has_variants? }

child :images => :images do
  extends "spree/api/images/show"
end

child :variants => :variants do
  extends "spree/api/variants/small"
end

child :product_properties => :product_properties do
  attributes *product_property_attributes
end
