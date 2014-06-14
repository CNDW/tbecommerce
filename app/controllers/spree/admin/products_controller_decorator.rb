module Spree
	module Admin
		ProductsController.class_eval do 
		protected
			def permit_attributes
        params.require(:product).permit(:product_category, :product_subcategory)
      end
		end
	end
end