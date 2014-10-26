module Spree
  module Admin
    OrdersController.class_eval do

      private
        def load_order
          @order = Order.includes(order_includes).find_by_number!(params[:id])
          authorize! action, @order
        end

        def order_includes
          [:adjustments]
        end
    end
  end
end