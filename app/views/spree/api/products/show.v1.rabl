object @product => :product
cache [I18n.locale, current_currency, root_object]
attributes *product_attributes
attributes :product_category, :product_subcategory, :specs, :tagline, :color_type_ids, :option_type_ids, :property_ids, :featured
node(:display_price) { |p| p.display_price.to_s }

child :images => :images do
  extends "spree/api/images/show"
end

