class ChangeSpreeProductColorTypesForeignKeynames < ActiveRecord::Migration
  def change
    rename_column :spree_product_color_types, :spree_product_id, :product_id
    rename_column :spree_product_color_types, :spree_color_type_id, :color_type_id
  end
end
