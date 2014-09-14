module Spree
  module Admin
    ProductsHelper.class_eval do
      def color_types_colors_for(product)
        colors = @color_types.map do |color_type|
          selected = product.color_types.include?(color_type)
          content_tag(:color,
                      :value    => color_type.id,
                      :selected => ('selected' if selected)) do
            color_type.name
          end
        end.join("").html_safe
      end
    end
  end
end