module Spree
  Variant.class_eval do
    has_many :variant_colors, dependent: :destroy

    delegate :color_types, to: :product
    after_save :update_variant_colors
    accepts_nested_attributes_for :variant_colors, reject_if: lambda { |pp| pp[:color_value_id].blank? }

    def update_variant_colors
      self.variant_colors.each {|color| self.variant_colors.delete(color) unless self.variant_color_type_ids.include?(color.color_type_id)}
      self.add_variant_colors
    end

    def variant_color_type_ids
      self.variant_colors.includes(:color_type).map {|color| color.color_type_id}
    end

    def add_variant_colors
      self.color_types.each {|type| self.variant_colors.create(color_type: type) unless self.variant_color_type_ids.include?(type.id) }
    end
  end
end
