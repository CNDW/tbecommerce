require "rails_helper"

module Spree
  describe Api::OrdersController, :type => :controller do
    render_views
    let(:product) { create(:product) }
    let(:currency) { 'USD' }
    let(:line_item) { create(:line_item) }

    def orders_url(order_data=nil)
      uri = "/api/orders"
      return uri if not order_data
      "#{uri}/#{order_data["number"]}?order_token=#{order_data["token"]}"
    end

    before(:each) do
      @variant = create(:variant, :product => product)
      api_post orders_url
      @order_data = json
      product.price = 15
      @variant.price = 10
    end

    it "can view their own order" do
      api_get orders_url(@order_data)
      expect(last_response).to be_successful
    end
  end
end
