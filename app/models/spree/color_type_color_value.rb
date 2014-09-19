module Spree
  class ColorTypeColorValue < Spree::Base
    belongs_to :color_value, inverse_of: :color_type_color_values
    belongs_to :color_type, inverse_of: :color_type_color_values
    acts_as_list scope: :color_value
  end
end