class AddDescriptionAndImagesToProductProperties < ActiveRecord::Migration
  def change
    add_column :spree_product_properties, :description, :text
  end
end
