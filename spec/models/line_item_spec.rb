require 'rails_helper'

describe Spree::LineItem, :type => :model do
  let(:order) { create :order_with_line_items, line_items_count: 1 }
  let(:line_item) { order.line_items.first }

  before { create(:store) }
end
