module Spree
	Product.class_eval do
		# delegate_belongs_to :master, :product_category, :product_subcategory
		# validates :product_category, presence: true
		# validates :product_subcategory, presence: true
    has_many :product_color_types, dependent: :destroy, inverse_of: :product
    has_many :color_types, through: :product_color_types

    attr_accessor :product_values_hash

    def self.categories
      @categories ||= Product.distinct.pluck(:product_category)
    end
	end
end