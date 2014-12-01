module Spree
  module Admin
    class ColorTypesController < ResourceController

      update.before :update_color_values

      protected

        def location_after_save
          if @color_type.created_at == @color_type.updated_at
            edit_admin_color_type_url(@color_type)
          else
            admin_color_types_url
          end
        end

      private
        def update_color_values
          puts params
          if params[:color_type][:color_value_ids].present?
            params[:color_type][:color_value_ids] = params[:color_type][:color_value_ids].split(',')
          end
          puts params
        end

        def load_product
          @product = Product.find_by_param!(params[:product_id])
        end

        def setup_new_color_value
          @color_type.color_values.build if @color_type.color_values.empty?
        end

        def set_available_color_types
          @available_color_types = if @product.color_type_ids.any?
            ColorType.where('id NOT IN (?)', @product.color_type_ids)
          else
            ColorType.all
          end
        end

    end
  end
end