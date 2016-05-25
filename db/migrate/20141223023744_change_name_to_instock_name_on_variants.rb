class ChangeNameToInstockNameOnVariants < ActiveRecord::Migration
  def change
    rename_column :spree_variants, :name, :instock_name
  end
end
