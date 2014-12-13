module Spree::Admin
  VariantsController.class_eval do
    def new
      @variant.save
      edit
    end
  end
end