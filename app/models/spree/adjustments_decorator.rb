module Spree
  Adjustment.class_eval do
    scope :custom_option, -> { where(source_type: 'Spree::OptionValue') }
  end
end