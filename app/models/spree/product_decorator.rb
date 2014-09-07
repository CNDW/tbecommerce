module Spree
	Product.class_eval do
		# delegate_belongs_to :master, :product_category, :product_subcategory
		# validates :product_category, presence: true
		# validates :product_subcategory, presence: true
    def self.catalogue
      @catalogue = {}
      Product.categories.each do |category|
        @catalogue.merge!({ category => Product.where(product_category: category) })
      end
      return @catalogue
    end

    def self.categories
      @categories ||= Product.distinct.pluck(:product_category)
    end
	end
end