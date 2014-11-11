class AddIndexForMockIds < ActiveRecord::Migration
  def change
    add_index :spree_product_mocks, [:product_id, :id], name: 'index_product_id_on_product_mock_and_product_mock_id'
  end
end
