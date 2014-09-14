module Spree
  class ProductColorType < Spree::Base
    belongs_to :product, class_name: 'Spree::Product', inverse_of: :product_color_types
    belongs_to :color_type, class_name: 'Spree::ColorType', inverse_of: :product_color_types
    acts_as_list scope: :product
  end
end