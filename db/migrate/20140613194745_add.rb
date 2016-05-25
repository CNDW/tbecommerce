class Add < ActiveRecord::Migration
  def change
    add_column :spree_products, :category, :string
    add_index :spree_products, :category

    add_column :spree_products, :type, :string
    add_index :spree_products, :type
  end
end
