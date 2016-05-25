class AddInCatalogueAndInCustomShopFlagsToProducts < ActiveRecord::Migration
  def change
    add_column :spree_products, :in_catalogue, :boolean, default: false
    add_column :spree_products, :in_custom_shop, :boolean, default: false
  end
end
