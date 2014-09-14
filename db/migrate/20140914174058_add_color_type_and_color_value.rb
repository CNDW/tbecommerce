class AddColorTypeAndColorValue < ActiveRecord::Migration
  def change
    remove_column :spree_option_types, :is_color

    create_table :spree_color_types do |t|
      t.string :name, :limit => 100
      t.string :presentation, :limit => 100
      t.integer :position, :default => 0, :null => false
      t.timestamps
      t.text :description
      t.boolean :required
      t.boolean :catalogue
      t.string :color_type_image_file_name
      t.string :color_type_image_content_type
      t.integer :color_type_image_file_size
      t.datetime :color_type_image_updated_at
    end

    create_table :spree_color_values do |t|
      t.string :name
      t.string :presentation
      t.text :description
      t.boolean :required
      t.decimal :price, precision: 8, scale: 2
      t.references :color_type
      t.timestamps
      t.string :color_image_file_name
      t.string :color_image_content_type
      t.integer :color_image_file_size
      t.datetime :color_image_updated_at
    end

    create_table :spree_product_color_types do |t|
      t.integer :position
      t.references :spree_product
      t.references :spree_color_type
      t.timestamps
    end

    create_table :spree_color_values_variants, :id => false do |t|
      t.references :variant
      t.references :color_value
    end

    add_index :spree_color_values_variants, [:variant_id, :color_value_id], :name => 'index_color_values_variants_on_variant_id_and_color_value_id'
    add_index :spree_color_values_variants, [:variant_id],                   :name => 'index_spree_color_values_variants_on_variant_id'
  end
end
