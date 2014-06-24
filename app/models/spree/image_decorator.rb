module Spree
  Image.class_eval do 
    def product_id
      self.viewable_id
    end
  end 
end