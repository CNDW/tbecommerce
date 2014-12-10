module Spree
  class ColorValue < Spree::Base
    has_many :color_type_color_values, dependent: :destroy, inverse_of: :color_value
    has_many :color_type, through: :color_type_color_values

    has_many :variant_colors, dependent: :destroy

    has_and_belongs_to_many :variants, join_table: 'spree_color_values_variants', class_name: "Spree::Variant"

    validates :name, :presentation, presence: true

    after_touch :touch_all_variants

    has_attached_file :color_image,
      styles: { web_large: '800x800>',
      web_medium: '600x600>',
      web_small: '200x200>',
      web_thumb: '64x64>' },
      default_style: :web_medium,
      url: '/spree/color_values/:id/:style/:basename.:extension',
      path: ':rails_root/public/spree/color_values/:id/:style/:basename.:extension',
      convert_options: { all: '-strip -auto-orient -colorspace sRGB' }
    validates_attachment :color_image,
      content_type: { content_type: %w(image/jpeg image/jpg image/png image/gif) }

    def thumb_url
      self.color_image.url(:web_thumb)
    end
    def large_url
      self.color_image.url(:web_large)
    end
    def medium_url
      self.color_image.url(:web_medium)
    end
    def small_url
      self.color_image.url(:web_small)
    end
    def touch_all_variants
      variants.update_all(updated_at: Time.current)
    end
  end
end