module Spree
  class VariantColor < Spree::Base
    belongs_to :variant
    belongs_to :color_type
    belongs_to :color_value

    delegate :color_values, to: :color_type
    delegate :color_value_ids, to: :color_type
    delegate :name, to: :color_type
  end
end