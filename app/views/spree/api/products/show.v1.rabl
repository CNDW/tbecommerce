object @product
cache @product, expires_in: 10.minutes
attributes :id, :name, :description, :price, :display_price, :slug, :meta_description, :meta_keywords, :shipping_category_id, :taxon_ids
attributes :product_category, :product_subcategory, :specs, :tagline, :color_type_ids, :option_type_ids, :property_ids, :featured, :master_variant_id, :shipping_category_id
node(:display_price) { |p| p.display_price.to_s }

child :images => :images do
  extends "spree/api/images/show"
end

child :product_mocks => :product_mocks do
  extends "spree/api/product_mocks/show"
end
