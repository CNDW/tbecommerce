class AddPathFlagToColorType < ActiveRecord::Migration
  def change
    add_column :spree_color_types, :line_color, :boolean, default: false
  end
end
