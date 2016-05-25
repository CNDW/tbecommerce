class AddPositionToColorValues < ActiveRecord::Migration
  def change
    add_column :spree_color_values, :position, :integer
  end
end
