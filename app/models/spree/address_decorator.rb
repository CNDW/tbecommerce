module Spree
  Address.class_eval do
    validates :email, presence: true, email: true
  end
end