module Spree
  ProductProperty.class_eval do
    has_attached_file :property_image, :styles => { :medium => "300x300>", :thumb => "100x100>" }, :default_url => "/spree/products/:product_id/product_properties/:id/:style/property_image.:extension'"
    validates_attachment_content_type :property_image, :content_type => /\Aimage\/.*\Z/
  end
end