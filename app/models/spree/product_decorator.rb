module Spree
	Product.class_eval do
    has_many :product_color_types, dependent: :destroy, inverse_of: :product
    has_many :color_types, through: :product_color_types

    attr_accessor :product_values_hash

    def self.categories
      @categories ||= Product.distinct.pluck(:product_category)
    end

    def master_variant_id
      self.master.id
    end
	end
end