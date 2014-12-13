module Spree
	Product.class_eval do
    has_many :product_color_types, dependent: :destroy, inverse_of: :product
    has_many :color_types, through: :product_color_types
    has_many :product_mocks, dependent: :destroy

    attr_accessor :product_values_hash

    def self.categories
      @categories ||= Product.distinct.pluck(:product_category)
    end

    def master_variant_id
      self.master.id
    end

    def option_values
      self.option_types.includes(:option_values).map {|type| type.option_values.map {|value| value} }.flatten
    end

    def option_value_ids
      self.option_types.includes(:option_values).map {|type| type.option_values.map {|value| value.id} }.flatten
    end

    def update_mock_positions
      index = 0
      self.product_mocks.order(:position).each do |mock|
        mock.update_attributes(:position => index)
        index = index + 1
      end
    end
  end
end