module Spree::Admin
  class ProductMocksController < ResourceController
    before_action :load_data
    # create.before :set_viewable
    # update.before :set_viewable

    private

      def location_after_destroy
        @product.update_mock_positions()
        admin_product_product_mocks_url(@product)
      end

      def location_after_save
        @product.update_mock_positions()
        admin_product_product_mocks_url(@product)
      end

      def load_data
        @product = Spree::Product.friendly.includes(:product_mocks).find(params[:product_id])
      end

    #   def set_viewable
    #     @image.viewable_type = 'Spree::Variant'
    #     @image.viewable_id = params[:image][:viewable_id]
    #   end
  end
end