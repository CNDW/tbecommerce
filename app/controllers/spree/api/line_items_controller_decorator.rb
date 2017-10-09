Spree::Api::LineItemsController.class_eval do
  self.line_item_options = [:custom_item_hash, :order_notes]

  def destroy
    @line_item = find_line_item
    hash = @line_item.custom_item_hash
    @order.contents.remove(hash, @line_item.quantity)
    respond_with(@order, status: 201)
  end
end
