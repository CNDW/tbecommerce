module Spree
  LineItem.class_eval do
    has_many :line_item_color_types, dependent: :destroy, inverse_of: :line_item
    has_many :color_types, through: :line_item_color_types
    has_many :line_item_option_values, dependent: :destroy, inverse_of: :line_item
    has_many :option_values, through: :line_item_option_values
    def deserialize_hash

    end
  end
end