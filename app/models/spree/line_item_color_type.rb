module Spree
  class LineItemColorType < Spree::Base
    belongs_to :line_item, inverse_of: :line_item_color_types
    belongs_to :color_type, inverse_of: :line_item_color_types
    acts_as_list scope: :line_item
  end
end