class ChangeTypeToProductType < ActiveRecord::Migration
  def change
  	rename_column :spree_products, :type, :product_type
  	rename_column :spree_products, :category, :product_category
  end
end
