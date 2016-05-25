class AddProductMock < ActiveRecord::Migration
  def change
    create_table :spree_product_mock do |t|
      t.string :name
      t.string :presentation
      t.integer :position, default: 0, null: false
      t.timestamps
      t.references :spree_product
    end
  end

  def self.up
    add_attachment :spree_product_mock, :product_mock_svg
  end

  def self.down
    add_attachment :spree_product_mock, :product_mock_svg
  end
end
