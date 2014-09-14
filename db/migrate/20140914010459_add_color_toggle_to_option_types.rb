class AddColorToggleToOptionTypes < ActiveRecord::Migration
  def change
    add_column :spree_option_types, :is_color, :boolean
  end
end
