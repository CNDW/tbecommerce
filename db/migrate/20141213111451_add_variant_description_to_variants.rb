class AddVariantDescriptionToVariants < ActiveRecord::Migration
  def change
    add_column :spree_variants, :description, :string
  end
end
