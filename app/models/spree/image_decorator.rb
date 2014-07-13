module Spree
  Image.class_eval do
    def product_id
      self.viewable_id
    end
    def image_id
      self.id
    end
    self.attachment_definitions[:attachment][:styles].merge!(
      carousel_large: '1200x1200>',
      carousel_medium: '1000x1000>',
      carousel_small: '800x800>'
    )
  end
end