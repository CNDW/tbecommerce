module Spree
  Image.class_eval do
    def product_id
      self.viewable_id
    end
    def image_id
      self.id
    end
    self.attachment_definitions[:attachment][:styles].merge!(
      web_large: '1274x980>',
      web_medium: '637x490>',
      web_small: '390x300>',
      web_thumb: '130x100>' )
  end
end