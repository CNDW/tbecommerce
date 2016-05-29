module Spree::Api
  VariantsController.class_eval do
    def index
      @variants = in_stock_scope.includes(variant_includes)
        .ransack(params[:q]).result
      respond_with(@variants)
    end

    private

      def variant_includes
        [{ option_values: :option_type }, :product, :default_price, :images, :variant_colors]
      end
      def in_stock_scope
        if @product
          variants = @product.variants.in_stock
        else
          variants = Spree::Variant.in_stock
        end
        variants.accessible_by(current_ability, :read)
      end
  end
end
