class AddAttachmentToProperties < ActiveRecord::Migration
  def self.up
    add_attachment :spree_properties, :image
    add_column :spree_properties, :description, :text
  end

  def self.down
    remove_attachment :spree_properties, :image
  end
end
