module Spree::Api
  OrdersController.class_eval do

    private
      def find_order(lock = false)
        @order = Spree::Order.lock(lock).find_by!(number: params[:id])
        raise_insufficient_quantity and return if @order.insufficient_stock_lines.present?
        @order.state = params[:state] if params[:state]
      end

      def order_params
        if params[:order] and not params[:order].empty?
          normalize_params
          params.require(:order).permit(permitted_order_attributes)
        else
          {}
        end
      end
  end
end
