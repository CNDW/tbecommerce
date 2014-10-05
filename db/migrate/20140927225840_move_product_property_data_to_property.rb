class MoveProductPropertyDataToProperty < ActiveRecord::Migration
  def change
    remove_column :spree_product_properties, :property_image_file_name
    remove_column :spree_product_properties, :property_image_content_type
    remove_column :spree_product_properties, :property_image_file_size
    remove_column :spree_product_properties, :property_image_updated_at
    remove_column :spree_product_properties, :description
    def self.up
      add_attachment :spree_properties, :image
      add_column :spree_properties, :description, :text
    end

    def self.down
      remove_attachment :spree_properties, :image
    end
  end
end
