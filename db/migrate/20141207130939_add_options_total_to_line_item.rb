class AddOptionsTotalToLineItem < ActiveRecord::Migration
  def change
    add_column :spree_line_items, :option_total, :decimal, precision: 10, scale: 2, default: 0.0
  end
end
