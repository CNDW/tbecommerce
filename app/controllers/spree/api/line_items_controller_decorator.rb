module Spree::Api
  LineItemsController.class_eval do
    def create
      variant = Spree::Variant.find(params[:line_item][:variant_id])
      @line_item = order.contents.add(variant, params[:line_item][:quantity] || 1, nil, nil, params[:line_item][:custom_item_hash])

      if @line_item.errors.empty?
        respond_with(@line_item, status: 201, default_template: :show)
      else
        invalid_resource!(@line_item)
      end
    end
    def destroy
      @line_item = find_line_item
      variant = Spree::Variant.find(@line_item.variant_id)
      @order.contents.remove(variant, @line_item.quantity)
      respond_with(@order, status: 204)
    end
  end
end