require "rails_helper"

module Spree
  describe Api::LineItemsController, :type => :controller do
    render_views
    let(:product) { create(:product) }
    let(:currency) { 'USD' }
    let(:line_item) { create(:line_item) }


    def line_items_url(order_data, line_item_id=nil)
      uri = "/api/orders/#{order_data["number"]}/line_items"
      uri = "#{uri}/#{line_item_id}" if line_item_id
      "#{uri}?order_token=#{order_data["token"]}"
    end

    before(:each) do
      @variant = create(:variant, :product => product)
      api_post "/api/orders"
      @order_data = json
      product.price = 15
      @variant.price = 10
    end

    it "can add a line_item to an order" do
      api_post line_items_url(@order_data), {
        :line_item => {
          :variant_id => @variant.id,
          :quantity => 1,
          :options => {  }
        }
      }
      expect(last_response).to be_successful
    end
  end
end
