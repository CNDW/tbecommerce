require "rails_helper"

RSpec.describe "Orders Api", :type => :request do
  let(:product) { create(:product) }
  let(:currency) { 'USD' }
  before(:each) do
    @variant = create(:variant, :product => product)
    product.price = 15
    @variant.price = 10
  end

  it "returns an order" do
  end
end
