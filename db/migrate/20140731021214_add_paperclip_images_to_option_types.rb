class AddPaperclipImagesToOptionTypes < ActiveRecord::Migration
  def self.up
    add_attachment :spree_option_types, :option_type_image
  end

  def self.down
    remove_attachment :spree_option_types, :option_type_image
  end
end
