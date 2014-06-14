module Spree
	Product.class_eval do 
		delegate_belongs_to :master, :product_category, :product_subcategory
		validates :product_category, presence: true
		validates :product_subcategory, presence: true
	end	
end