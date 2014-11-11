module Spree::Api
  ProductsController.class_eval do
    def index
      if params[:ids]
        @products = product_scope.where(:id => params[:ids].split(","))
      else
        @products = product_scope.ransack(params[:q]).result
        @color_types = Spree::ColorType.accessible_by(current_ability, :read).load.ransack(params[:q]).result.includes(:color_values)
        @color_values = Spree::ColorValue.accessible_by(current_ability, :read).load.ransack(params[:q]).result
        @option_types = Spree::OptionType.accessible_by(current_ability, :read).load.ransack(params[:q]).result.includes(:option_values)
        @properties = Spree::Property.accessible_by(current_ability, :read).load.ransack(params[:q]).result.includes(:products)
        @countries = Spree::Country.accessible_by(current_ability, :read).load.ransack(params[:q]).result.includes(:states).order('name ASC')
        @shipping_categories = Spree::ShippingCategory.all
        @shipping_methods = Spree::ShippingMethod.all
      end

      @products = @products.distinct
      expires_in 15.minutes, :public => true
      headers['Surrogate-Control'] = "max-age=#{15.minutes}"
      respond_with(@products)
    end

    def product_includes
      [ :properties, :option_types, :color_types, :taxons, :product_mocks, master: variants_associations ]
    end

    def variants_associations
      [{ option_values: :option_type }, :default_price, :images]
    end
  end
end