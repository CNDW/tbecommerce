module Spree
  module Admin
    class ColorValuesController < ResourceController
      def destroy
        color_value = Spree::ColorValue.find(params[:id])
        color_value.destroy
        render :text => nil
      end
    end
  end
end