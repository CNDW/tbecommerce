FactoryGirl.define do
  factory :color_value, class: Spree::LineItem do
    quantity 1
    price { BigDecimal.new('10.00') }
    pre_tax_amount { price }
    order
    transient do
      association :color_image
    end
    variant{ product.master }
  end
end
