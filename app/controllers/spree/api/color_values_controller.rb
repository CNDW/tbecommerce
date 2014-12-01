module Spree
  module Api
    class ColorValuesController < Spree::Api::BaseController
      def index
        if params[:ids]
          @color_values = Spree::ColorValue.accessible_by(current_ability, :read).where(:id => params[:ids].split(','))
        else
          @color_values = Spree::ColorValue.accessible_by(current_ability, :read).load.ransack(params[:q]).result
        end

        expires_in 15.minutes, :public => true
        headers['Surrogate-Control'] = "max-age=#{15.minutes}"
        respond_with(@color_values)
      end

      def show
        @color_value = Spree::ColorValue.accessible_by(current_ability, :read).find(params[:id])
        respond_with(@color_value)
      end

      def create
        authorize! :create, Spree::ColorValue
        @color_value = Spree::ColorValue.new(color_value_params)
        if @color_value.save
          render :show, :status => 201
        else
          invalid_resource!(@color_value)
        end
      end

      def update
        authorize! :update, Spree::ColorValue
        @color_value = Spree::ColorValue.accessible_by(current_ability, :update).find(params[:id])
        if @color_value.update_attributes(color_value_params)
          render :show
        else
          invalid_resource!(@color_value)
        end
      end

      def destroy
        authorize! :destroy, Spree::ColorValue
        @color_value = Spree::ColorValue.accessible_by(current_ability, :destroy).find(params[:id])
        @color_value.destroy
        render :text => nil, :status => 204
      end

      private
        def color_value_params
          params.require(:color_value).permit! #(permitted_color_value_attributes)
        end
    end
  end
end