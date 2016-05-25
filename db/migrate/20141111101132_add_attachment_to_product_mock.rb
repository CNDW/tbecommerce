class AddAttachmentToProductMock < ActiveRecord::Migration
  def self.up
    add_attachment :spree_product_mocks, :product_mock_svg
  end

  def self.down
    remove_attachment :spree_product_mocks, :product_mock_svg
  end
end
