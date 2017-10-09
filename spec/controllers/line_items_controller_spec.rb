require "rails_helper"

module Spree
  describe Api::LineItemsController, :type => :controller do
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

    it "can add a line_item to an order" do
      api_post(:create, {
        :number => @order_data[:number],
        :order_token => @order_data[:token],
        :line_item => { :variant_id => @variant.id }
      })
      expect(response.status).to eq(200)
    end
  end
end
