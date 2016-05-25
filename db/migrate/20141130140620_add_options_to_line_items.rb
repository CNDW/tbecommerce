class AddOptionsToLineItems < ActiveRecord::Migration
  def change
    create_table :spree_line_item_color_types do |t|
      t.references :color_type
      t.references :line_item
      t.timestamps
    end
    create_table :spree_line_item_option_values do |t|
      t.references :option_value
      t.references :line_item
    end
    add_index :spree_line_item_color_types, [:color_type_id, :line_item_id], name: 'index_line_item_color_types_on_color_type_id_and_line_item_id'
    add_index :spree_line_item_option_values, [:line_item_id, :option_value_id], name: 'index_line_item_option_values_on_option_value_and_line_item_ids'
  end
end
