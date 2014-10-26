module Spree::Api
  LineItemsController.class_eval do
    def destroy
      @line_item = find_line_item
      variant = Spree::Variant.find(@line_item.variant_id)
      @order.contents.remove(variant, @line_item.quantity)
      respond_with(@order, status: 204)
    end
  end
end