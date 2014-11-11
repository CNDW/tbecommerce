module Spree
  class ProductMock < Spree::Base
    belongs_to :product

    after_touch :touch_product

    has_attached_file :product_mock_svg,
      url: '/spree/product_mocks/:id/:basename.:extension',
      path: ':rails_root/public/spree/product_mocks/:id/:basename.:extension'

    validates_attachment :product_mock_svg,
      content_type: { content_type: ['image/svg+xml', 'text/html'] }

    do_not_validate_attachment_file_type :product_mock_svg

    def touch_product
      product.update(updated_at: Time.current)
    end
  end
end