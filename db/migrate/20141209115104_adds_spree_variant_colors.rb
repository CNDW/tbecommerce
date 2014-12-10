class AddsSpreeVariantColors < ActiveRecord::Migration
  def change
    create_table :spree_variant_colors do |t|
      t.belongs_to :variant, index: true
      t.belongs_to :color_type, index: true
      t.belongs_to :color_value, index: true
    end
  end
end
