module Spree
  ProductProperty.class_eval do
    has_attached_file :property_image,
      styles: { web_large: '1274x980>',
      web_medium: '637x490>',
      web_small: '390x300>',
      web_thumb: '130x100>' },
      default_style: :web_medium,
      url: '/spree/product_properties/:id/:style/:basename.:extension',
      path: ':rails_root/public/spree/product_properties/:id/:style/:basename.:extension',
      convert_options: { all: '-strip -auto-orient -colorspace sRGB' }
    validates_attachment :property_image,
      content_type: { :content_type => %w(image/jpeg image/jpg image/png image/gif) }


    def thumb_url
      self.property_image.url(:web_thumb)
    end
    def large_url
      self.property_image.url(:web_large)
    end
    def medium_url
      self.property_image.url(:web_medium)
    end
    def small_url
      self.property_image.url(:web_small)
    end
  end
end