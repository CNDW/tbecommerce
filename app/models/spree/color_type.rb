module Spree
  class ColorType < Spree::Base
    has_many :color_types_values, dependent: :destroy, inverse_of: :color_type
    has_many :color_values, -> { order(:position) }, through: :color_types_values
    has_many :product_color_types, dependent: :destroy, inverse_of: :color_type
    has_many :products, through: :product_color_types
    # has_and_belongs_to_many :prototypes, join_table: 'spree_color_types_prototypes'

    validates :name, :presentation, presence: true
    default_scope -> { order("#{self.table_name}.position") }

    accepts_nested_attributes_for :color_values, reject_if: lambda { |ov| ov[:name].blank? || ov[:presentation].blank? }, allow_destroy: true

    after_touch :touch_all_products

    has_attached_file :color_type_image,
      styles: { web_large: '1274x980>',
      web_medium: '637x490>',
      web_small: '390x300>',
      web_thumb: '130x100>' },
      default_style: :web_medium,
      url: '/spree/color_types/:id/:style/:basename.:extension',
      path: ':rails_root/public/spree/color_types/:id/:style/:basename.:extension',
      convert_options: { all: '-strip -auto-orient -colorspace sRGB' }
    validates_attachment :color_type_image,
      content_type: { content_type: %w(image/jpeg image/jpg image/png image/gif) }

    def thumb_url
      self.color_type_image.url(:web_thumb)
    end
    def large_url
      self.color_type_image.url(:web_large)
    end
    def medium_url
      self.color_type_image.url(:web_medium)
    end
    def small_url
      self.color_type_image.url(:web_small)
    end
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