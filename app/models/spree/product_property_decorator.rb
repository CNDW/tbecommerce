module Spree
  ProductProperty.class_eval do
    has_attached_file :property_image,
      styles: { medium: "300x300>", thumb: "100x100>", large: "700x700>" },
      default_style: :medium,
      url: '/spree/products/:id/product_properties/:id/:style/:basename.:extension',
      path: ':rails_root/public/spree/products/:id/product_properties/:id/:style/:basename.:extension',
      convert_options: { all: '-strip -auto-orient -colorspace sRGB' }
      # url: "/spree/products/:product_id/product_properties/:id/:style/property_image.:extension"
    validates_attachment :property_image,
      content_type: { :content_type => %w(image/jpeg image/jpg image/png image/gif) }


    def thumb_url
      self.property_image.url(:thumb)
    end
    def large_url
      self.property_image.url(:large)
    end
    def medium_url
      self.property_image.url(:medium)
    end
  end
end