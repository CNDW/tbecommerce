class AddTaglineToShippingMethod < ActiveRecord::Migration
  def change
    add_column :spree_shipping_methods, :tagline, :string
  end
end
