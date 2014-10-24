module Spree::Admin
  ShippingMethodsController.class_eval do

    private
      def load_data
        @available_zones = Spree::Zone.order(:name)
        @tax_categories = Spree::TaxCategory.order(:name)
        @calculators = Spree::ShippingMethod.calculators.sort_by(&:name)
      end
  end
end