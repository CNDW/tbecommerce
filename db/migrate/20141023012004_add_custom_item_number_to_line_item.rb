class AddCustomItemNumberToLineItem < ActiveRecord::Migration
  def change
    add_column :spree_line_items, :custom_item_hash, :string
    add_index :spree_line_items, [:custom_item_hash], :name => 'index_custom_item_hash_online_items'
  end
end
