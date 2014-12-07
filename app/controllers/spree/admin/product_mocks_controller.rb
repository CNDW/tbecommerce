module Spree::Admin
  class ProductMocksController < ResourceController
    before_action :load_data

    private

      def load_data
        @product = Spree::Product.friendly.includes(:product_mocks).find(params[:product_id])
      end
  end
end