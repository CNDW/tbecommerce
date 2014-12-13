class AddInstockDescriptionToVariants < ActiveRecord::Migration
  def change
    remove_column :spree_variants, :description
    add_column :spree_variants, :instock_description, :string, default: ''
  end
end
