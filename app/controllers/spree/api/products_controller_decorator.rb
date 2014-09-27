module Spree::Api
  ProductsController.class_eval do
    def index
      if params[:ids]
        @products = product_scope.where(:id => params[:ids].split(","))
      else
        @products = product_scope.ransack(params[:q]).result
      end

      @products = @products.distinct
      expires_in 15.minutes, :public => true
      headers['Surrogate-Control'] = "max-age=#{15.minutes}"
      respond_with(@products)
    end
  end
end