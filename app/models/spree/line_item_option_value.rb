module Spree
  class LineItemOptionValue < Spree::Base
    belongs_to :line_item, inverse_of: :line_item_option_values
    belongs_to :option_value, inverse_of: :line_item_option_values
    acts_as_list scope: :line_item
  end
end