class AddsColorTypeValuesTable < ActiveRecord::Migration
  def change
    create_table :spree_color_types_values do |t|
      t.integer :position
      t.references :color_value
      t.references :color_type
      t.timestamps
    end
    remove_column :spree_color_values, :color_type_id

    add_index :spree_color_types_values, [:color_type_id, :color_value_id], name: 'index_color_types_values_on_color_type_id_and_color_value_id'
  end
end
