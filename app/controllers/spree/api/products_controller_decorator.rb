module Spree::Api
  ProductsController.class_eval do
    def bag_catalogue
      @products = Spree::Product.where(product_category: 'bag')
      expires_in 15.minutes, :public => true
      headers['Surrogate-Control'] =  "max-age-#{15.minutes}"
      render "spree/api/products/catalogue"
    end
    def apparel_catalogue
      @products = Spree::Product.where(product_category: 'apparel')
      expires_in 15.minutes, :public => true
      headers['Surrogate-Control'] =  "max-age-#{15.minutes}"
      render "spree/api/products/catalogue"
    end
    def utility_catalogue
      @products = Spree::Product.where(product_category: 'utility')
      expires_in 15.minutes, :public => true
      headers['Surrogate-Control'] =  "max-age-#{15.minutes}"
      render "spree/api/products/catalogue"
    end
  end
end