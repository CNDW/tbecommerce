module Spree
  ProductProperty.class_eval do
    has_many :images, -> { order(:position) }, as: :viewable, dependent: :destroy, class_name: "Spree::Image"
  end
end