class RemoveDescriptionAndBooleansFromColorTypeAndAddSelector < ActiveRecord::Migration
  def change
    remove_column :spree_color_types, :required
    remove_column :spree_color_types, :description
    remove_column :spree_color_types, :color_type_image_file_name
    remove_column :spree_color_types, :color_type_image_content_type
    remove_column :spree_color_types, :color_type_image_file_size
    remove_column :spree_color_types, :color_type_image_updated_at
    remove_column :spree_color_types, :catalogue
    add_column :spree_color_types, :selector, :string
  end
end
