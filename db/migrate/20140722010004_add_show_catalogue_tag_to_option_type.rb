class AddShowCatalogueTagToOptionType < ActiveRecord::Migration
  def change
    add_column :spree_option_types, :catalogue, :boolean
  end
end
