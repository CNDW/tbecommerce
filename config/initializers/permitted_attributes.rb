module Spree
  module PermittedAttributes
    @@product_attributes = [
      :name, :description, :available_on, :permalink, :meta_description,
      :meta_keywords, :price, :sku, :deleted_at, :prototype_id,
      :option_values_hash, :weight, :height, :width, :depth,
      :shipping_category_id, :tax_category_id,
      :taxon_ids, :option_type_ids, :cost_currency, :cost_price, :product_category, :product_subcategory]
    @@variant_attributes = [
      :name, :presentation, :cost_price, :lock_version,
      :position, :option_value_ids,
      :product_id, :product, :option_values_attributes, :price,
      :weight, :height, :width, :depth, :product_category, :product_subcategory, :sku, :cost_currency, options: [ :name, :value ]]
  end
end