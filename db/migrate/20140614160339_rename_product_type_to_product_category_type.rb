class RenameProductTypeToProductCategoryType < ActiveRecord::Migration
  def change
  	rename_column :spree_products, :product_type, :product_category_type
  end
end
