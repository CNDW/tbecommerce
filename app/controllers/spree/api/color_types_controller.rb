module Spree
  module Api
    class ColorTypesController < Spree::Api::BaseController
      def index
        if params[:ids]
          @color_types = Spree::ColorType.accessible_by(current_ability, :read).where(:id => params[:ids].split(','))
        else
          @color_types = Spree::ColorType.accessible_by(current_ability, :read).load.ransack(params[:q]).result
        end

        expires_in 15.minutes, :public => true
        headers['Surrogate-Control'] = "max-age=#{15.minutes}"
        respond_with(@color_types)
      end

      def show
        @color_type = Spree::ColorType.accessible_by(current_ability, :read).find(params[:id])
        respond_with(@color_type)
      end

      def create
        authorize! :create, Spree::ColorType
        @color_type = Spree::ColorType.new(color_type_params)
        if @color_type.save
          render :show, :status => 201
        else
          invalid_resource!(@color_type)
        end
      end

      def update
        authorize! :update, Spree::ColorType
        @color_type = Spree::ColorType.accessible_by(current_ability, :update).find(params[:id])
        if @color_type.update_attributes(color_type_params)
          render :show
        else
          invalid_resource!(@color_type)
        end
      end

      def destroy
        authorize! :destroy, Spree::ColorType
        @color_type = Spree::ColorType.accessible_by(current_ability, :destroy).find(params[:id])
        @color_type.destroy
        render :text => nil, :status => 204
      end

      private
        def color_type_params
          params.require(:color_type).permit! #(permitted_color_type_attributes)
        end
    end
  end
end