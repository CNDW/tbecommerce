module Spree
  LineItem.class_eval do
    has_many :line_item_color_types, dependent: :destroy, inverse_of: :line_item
    has_many :color_types, through: :line_item_color_types
    has_many :line_item_option_values, dependent: :destroy, inverse_of: :line_item
    has_many :option_values, through: :line_item_option_values

    before_save :deserialize_hash, unless: :skip_callbacks

    def has_notes
      self.order_notes != nil
    end

    def hash_colors
      segments = self.custom_item_hash.split('e')
      color_types = variant.product.color_types
      color_values = Spree::ColorValue.all
      segments.each do |segment|
        if segment.include?('ct')
          segment.split('i').shift
          @color_hash = segment
        end
      end
      @color_data = color_types.map do |type|
        result = {}
        color_segment = @color_hash.split('i')
        result['typename'] = type.name
        id_seg = color_segment.select do |seg|
          seg.split('s')[0] == type.id.to_s
        end

        result['valuename'] = color_values.find(id_seg[0].split('s')[1].to_i).name
        result
      end
      @color_data
    end

    def deserialize_hash
      custom_item_hash = self.custom_item_hash || ''
      segments = custom_item_hash.split('e')
      segments.each do |segment|
        if segment.include?('ov')
          self.option_value_ids = segment.split('i').drop(1)
          self.adjustments_for_option_values
        end
      end
    end

    def adjustments_for_option_values
      @skip_callbacks = true
      adjustment_option_ids = self.adjustments.custom_option.map{ |o| o.source_id }.uniq
      self.adjustments.custom_option.each do |adjustment|
        adjustment.destroy if adjustment_option_ids.include? adjustment.source_id
      end
      self.option_values.each do |option|
        Spree::Adjustment.create(
          source: option,
          amount: option.price,
          label: option.name,
          order: self.order,
          adjustable: self) unless adjustment_option_ids.include?(option.id)
      end
      @skip_callbacks = false
    end

    def option_amount
      adjustments.custom_option.map do |option|
        option.amount
      end.compact.sum
    end

    private
      def skip_callbacks
        @skip_callbacks ||= false
      end

  end
end
