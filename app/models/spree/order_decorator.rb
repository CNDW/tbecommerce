Spree::Order.class_eval do

  before_save :update_order_email

  def require_email
    false
  end

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

  #not planning to ever store credit card information on server
  # This works around it
  def temporary_credit_card
    true
  end

  # don't mail
  def deliver_order_confirmation_email
    true
  end

  def link_by_email
    self.email = user.email if self.user
  end

  def update_order_email
    self.email = self.bill_address.email if self.bill_address and self.email == nil
  end

end
