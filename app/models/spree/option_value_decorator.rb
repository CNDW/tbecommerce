module Spree
  OptionValue.class_eval do
    has_many :line_item_option_values, dependent: :destroy, inverse_of: :line_item
    has_many :line_items, through: :line_item_option_values

    has_attached_file :option_image,
      styles: { web_large: '1274x980>',
      web_medium: '637x490>',
      web_small: '390x300>',
      web_thumb: '130x100>' },
      default_style: :web_medium,
      url: '/spree/option_values/:id/:style/:basename.:extension',
      path: ':rails_root/public/spree/option_values/:id/:style/:basename.:extension',
      convert_options: { all: '-strip -auto-orient -colorspace sRGB' }
    validates_attachment :option_image,
      content_type: { content_type: %w(image/jpeg image/jpg image/png image/gif) }

    def thumb_url
      self.option_image.url(:web_thumb)
    end
    def large_url
      self.option_image.url(:web_large)
    end
    def medium_url
      self.option_image.url(:web_medium)
    end
    def small_url
      self.option_image.url(:web_small)
    end
  end
end