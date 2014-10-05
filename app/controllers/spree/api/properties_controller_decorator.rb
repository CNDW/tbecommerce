module Spree::Api
  PropertiesController.class_eval do
    def index
      @properties = Spree::Property.accessible_by(current_ability, :read)

      if params[:ids]
        @properties = @properties.where(:id => params[:ids].split(","))
      else
        @properties = @properties.ransack(params[:q]).result
      end

      respond_with(@properties)
    end
  end
end