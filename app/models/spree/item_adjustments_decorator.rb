module Spree
  ItemAdjustments.class_eval do
    define_callbacks :custom_option_adjustments

    def update_adjustments
      promo_total = 0
      option_total = 0
      run_callbacks :custom_option_adjustments do
        option_total = adjustments.custom_option.reload.map do |option|
          option.amount
        end.compact.sum
      end

      run_callbacks :promo_adjustments do
        promotion_total = adjustments.promotion.reload.map do |adjustment|
          adjustment.update!(@item)
        end.compact.sum

        unless promotion_total == 0
          choose_best_promotion_adjustment
        end
        promo_total = best_promotion_adjustment.try(:amount).to_f
      end

      included_tax_total = 0
      additional_tax_total = 0
      run_callbacks :tax_adjustments do
        tax = (item.respond_to?(:all_adjustments) ? item.all_adjustments : item.adjustments).tax
        included_tax_total = tax.included.reload.map(&:update!).compact.sum
        additional_tax_total = tax.additional.reload.map(&:update!).compact.sum
      end

      item.update_columns(
        :option_total => option_total,
        :promo_total => promo_total,
        :included_tax_total => included_tax_total,
        :additional_tax_total => additional_tax_total,
        :adjustment_total => option_total + promo_total + additional_tax_total,
        :updated_at => Time.now,
      )
    end
  end
end
