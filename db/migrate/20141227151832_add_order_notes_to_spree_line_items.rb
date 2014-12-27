class AddOrderNotesToSpreeLineItems < ActiveRecord::Migration
  def change
    add_column :spree_line_items, :order_notes, :text
  end
end
