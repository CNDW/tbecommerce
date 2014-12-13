attributes *variant_attributes

node(:display_price) { |p| p.display_price.to_s }
node(:options_text) { |v| v.options_text }
node(:total_on_hand) { |v| v.total_on_hand }

attributes :option_value_ids, :image_ids, :product_id, :instock_description
child :variant_colors => :variant_colors do
  attributes :color_type_id, :color_value_id
end