module Spree
  class VariantColor < Spree::Base
    belongs_to :variant
    belongs_to :color_type
    belongs_to :color_value
  end
end