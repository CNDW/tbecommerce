module Spree
  OptionType.class_eval do
    has_attached_file :option_type_image,
      styles: { medium: "300x300>", thumb: "100x100>", large: "600x600>" },
      default_style: :medium,
      url: '/spree/option_types/:id/:style/:basename.:extension',
      path: ':rails_root/public/spree/option_types/:id/:style/:basename.:extension',
      convert_options: { all: '-strip -auto-orient -colorspace sRGB' }
    validates_attachment :option_type_image,
      content_type: { content_type: %w(image/jpeg image/jpg image/png image/gif) }

    def thumb_url
      self.option_type_image.url(:thumb)
    end
    def large_url
      self.option_type_image.url(:large)
    end
    def medium_url
      self.option_type_image.url(:medium)
    end
  end
end