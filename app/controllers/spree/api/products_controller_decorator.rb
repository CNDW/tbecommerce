module Spree::Api
  ProductsController.class_eval do
    def index
      if params[:ids]
        @products = product_scope.where(:id => params[:ids].split(","))
      else
        @products = product_scope.ransack(params[:q]).result
        @color_types = Spree::ColorType.accessible_by(current_ability, :read).load.ransack().result
        @color_values = Spree::ColorValue.accessible_by(current_ability, :read).load.ransack().result
        @option_types = Spree::OptionType.accessible_by(current_ability, :read).load.ransack().result
      end

      @products = @products.distinct
      expires_in 15.minutes, :public => true
      headers['Surrogate-Control'] = "max-age=#{15.minutes}"
      respond_with(@products)
    end

    def product_includes
      [ :option_types, :color_types, variants: variants_associations, master: variants_associations ]
    end
  end
end