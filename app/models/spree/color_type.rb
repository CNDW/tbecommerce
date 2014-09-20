module Spree
  class ColorType < Spree::Base
    has_many :color_type_color_values, dependent: :destroy, inverse_of: :color_type
    has_many :color_values, through: :color_type_color_values
    has_many :product_color_types, dependent: :destroy, inverse_of: :color_type
    has_many :products, through: :product_color_types
    # has_and_belongs_to_many :prototypes, join_table: 'spree_color_types_prototypes'

    validates :name, :presentation, :selector, presence: true
    default_scope -> { order("#{self.table_name}.position") }

    accepts_nested_attributes_for :color_values, reject_if: lambda { |ov| ov[:name].blank? || ov[:presentation].blank? }, allow_destroy: true

    after_touch :touch_all_products

    def color_type_name
      color_type.name
    end

    def color_type_presentation
      color_type.presentation
    end
    def touch_all_products
      products.update_all(updated_at: Time.current)
    end
  end
end