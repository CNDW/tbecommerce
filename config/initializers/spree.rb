# Configure Spree Preferences
#
# Note: Initializing preferences available within the Admin will overwrite any changes that were made through the user interface when you restart.
#       If you would like users to be able to update a setting with the Admin it should NOT be set here.
#
# In order to initialize a setting do:
# config.setting_name = 'new value'
Spree.config do |config|
  # Example:
  # Uncomment to override the default site name.
  # config.site_name = "Spree Demo Site"
end

Spree::Auth::Config[:registration_step] = false

Spree::Api::Config[:requires_authentication] = false

Spree::Api::ApiHelpers.product_attributes.concat([:product_category, :product_subcategory, :specs])

Spree::Api::ApiHelpers.property_attributes.concat([:description, :thumb_url, :medium_url, :large_url])

Spree::Api::ApiHelpers.option_value_attributes.concat([:description, :thumb_url, :medium_url, :large_url, :price])

Spree::Api::ApiHelpers.option_type_attributes.concat([:description, :required, :catalogue])

Spree::PermittedAttributes.address_attributes.concat([:email])

Spree.user_class = "Spree::User"
