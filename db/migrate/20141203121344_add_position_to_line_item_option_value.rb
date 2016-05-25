class AddPositionToLineItemOptionValue < ActiveRecord::Migration
  def change
    add_column :spree_line_item_color_types, :position, :integer
    add_column :spree_line_item_option_values, :position, :integer
  end
end
