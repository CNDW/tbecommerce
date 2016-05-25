class AddNameToVariants < ActiveRecord::Migration
  def change
    add_column :spree_variants, :name, :string, :default => ''
  end
end
