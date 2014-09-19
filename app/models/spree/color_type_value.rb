module Spree
  class ColorTypeValue < Spree::Base
    belongs_to :color_value, class_name: 'Spree::ColorValue', inverse_of: :color_types_values
    belongs_to :color_type, class_name: 'Spree::ColorType', inverse_of: :color_types_values
    acts_as_list scope: :color_value
  end
end