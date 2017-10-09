require "rails_helper"

module Spree
  describe Api::OrdersController, :type => :controller do
    render_views
    let(:product) { create(:product) }
    let(:currency) { 'USD' }
    let(:line_item) { create(:line_item) }

    before(:each) do
      @variant = create(:variant, :product => product)
      api_post :create
      @order_data = json_response
      product.price = 15
      @variant.price = 10
    end

    it "can view their own order" do
      api_get :show, :id => @order_data[:number], :order_token => @order_data[:token]
      expect(response.status).to eq(200)
    end
  end
end
