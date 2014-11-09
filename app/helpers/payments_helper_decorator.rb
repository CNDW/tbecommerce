module Spree::Admin
  PaymentsHelper.class_eval do
    def payment_method_name(payment)
      # hack to allow us to retrieve the name of a "deleted" payment method
      id = payment.payment_method_id
      if id == nil
        "Unknown PaymentMethod"
      else
        Spree::PaymentMethod.find_with_destroyed(id).name
      end
    end
  end
end