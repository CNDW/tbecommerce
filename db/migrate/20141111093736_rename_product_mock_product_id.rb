class RenameProductMockProductId < ActiveRecord::Migration
  def change
    rename_table :spree_product_mock, :spree_product_mocks
    rename_column :spree_product_mocks, :spree_product_id, :product_id
  end
end
