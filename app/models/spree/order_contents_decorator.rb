module Spree
  OrderContents.class_eval do
    def add(variant, quantity = 1, currency = nil, shipment = nil, custom_item_hash = "pvi#{variant.id}")
      line_item = add_to_line_item(variant, quantity, currency, shipment, custom_item_hash)
      reload_totals
      shipment.present? ? shipment.update_amounts : order.ensure_updated_shipments
      PromotionHandler::Cart.new(order, line_item).activate
      ItemAdjustments.new(line_item).update
      reload_totals
      line_item
    end

    private
      def add_to_line_item(variant, quantity, currency=nil, shipment=nil, custom_item_hash = "pvi#{variant.id}")
        line_item = grab_line_item_by_hash(custom_item_hash)

        if line_item
          line_item.target_shipment = shipment
          line_item.quantity += quantity.to_i
          line_item.currency = currency unless currency.nil?
        else
          line_item = order.line_items.new(quantity: quantity, variant: variant, custom_item_hash: custom_item_hash)
          line_item.target_shipment = shipment
          if currency
            line_item.currency = currency
            line_item.price    = variant.price_in(currency).amount
          else
            line_item.price    = variant.price
          end
        end

        line_item.save
        line_item
      end

      def grab_line_item_by_hash(hash, raise_error = false)
        line_item = order.find_line_item_by_hash(hash)

        if !line_item.present? && raise_error
          raise ActiveRecord::RecordNotFound, "Line item not found for variant #{variant.sku}"
        end

        line_item
      end

      def grab_line_item_by_variant(variant, raise_error = false)
        puts "DEPRECATED:: grab_line_item_by_variant => called by #{caller_locations(1,1)[0].label}"
        line_item = order.find_line_item_by_hash("pvi#{variant.id}", raise_error)

        line_item
      end
  end
end