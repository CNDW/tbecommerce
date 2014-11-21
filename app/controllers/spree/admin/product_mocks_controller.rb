module Spree::Admin
  class ProductMocksController < ResourceController
    before_action :load_data
    before_action :update_positions, only: [:update]
    # create.before :set_viewable
    # update.before :set_viewable

    private

      def location_after_destroy
        admin_product_product_mocks_url(@product)
      end

      def location_after_save
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