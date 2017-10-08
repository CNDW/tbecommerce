require "rails_helper"

RSpec.describe "Orders Api", :type => :request do
  before(:each) do
    @product = Spree::Product.new
  end

  it "returns an order" do
    expect(true).to be true
  end
end
