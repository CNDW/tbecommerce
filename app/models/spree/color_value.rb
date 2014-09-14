module Spree
  class ColorValue < Spree::Base
    belongs_to :color_type, class_name: 'Spree::ColorType', touch: true, inverse_of: :color_values
    acts_as_list scope: :color_type
    has_and_belongs_to_many :variants, join_table: 'spree_color_values_variants', class_name: "Spree::Variant"

    validates :name, :presentation, presence: true

    after_touch :touch_all_variants

    has_attached_file :color_image,
      styles: { web_large: '1274x980>',
      web_medium: '637x490>',
      web_small: '390x300>',
      web_thumb: '130x100>' },
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