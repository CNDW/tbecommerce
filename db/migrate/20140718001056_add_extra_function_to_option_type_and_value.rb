class AddExtraFunctionToOptionTypeAndValue < ActiveRecord::Migration
  def change
    add_column :spree_option_types, :description, :text
    add_column :spree_option_types, :required, :boolean

    add_column :spree_option_values, :description, :text
    add_column :spree_option_values, :price, :decimal, precision: 8, scale: 2
  end
end
