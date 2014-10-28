module Spree
  Order.class_eval do

    def contains?(hash)
      find_line_item_by_hash(hash).present?
    end

    def quantity_of(hash)
      line_item = find_line_item_by_hash(hash)
      line_item ? line_item.quantity : 0
    end

    def find_line_item_by_hash(hash)
      line_items.detect { |line_item| line_item.custom_item_hash == hash }
    end

    def find_line_item_by_variant(variant)
      #overridden method, deprecated in this version of spree
      puts "DEPRECATED:: find_line_item_by_variant => called by #{caller_locations(1,1)[0].label}"
      #forward to the new intended method with default hash
      find_line_item_by_hash("pvi#{variant.id}")
    end

  end
end
