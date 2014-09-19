class RenameColorTypeValueToColorTypeColorValue < ActiveRecord::Migration
  def change
    rename_table :spree_color_types_values, :spree_color_type_color_values
  end
end
