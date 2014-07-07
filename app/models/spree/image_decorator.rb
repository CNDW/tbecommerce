module Spree
  Image.class_eval do 
    def product_id
      self.viewable_id
    end
    def image_id
      self.id
    end
  end 
end