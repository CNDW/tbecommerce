module Spree
  Variant.class_eval do
    has_many :variant_colors, dependent: :destroy

    delegate :color_types, to: :product
    after_create :update_variant_colors
    before_save :update_variant_colors

    def update_variant_colors
      self.variant_colors.each {|color| self.variant_colors.delete(color) unless self.variant_color_type_ids.include?(color.color_type_id)}
      self.color_types.each {|type| self.variant_colors.create(color_type: type) unless self.variant_color_type_ids.include?(type.id) }
    end

    def variant_color_type_ids
      self.variant_colors.map {|color| color.color_type_id}
    end

  end
end