class AddOptionValueImageColumn < ActiveRecord::Migration
  def self.up
    add_attachment :spree_option_values, :option_image
  end

  def self.down
    remove_attachment :spree_option_values, :option_image
  end
end
