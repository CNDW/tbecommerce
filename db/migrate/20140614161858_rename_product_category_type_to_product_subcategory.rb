class RenameProductCategoryTypeToProductSubcategory < ActiveRecord::Migration
  def change
  	rename_column :spree_products, :product_category_type, :product_subcategory
  end
end
