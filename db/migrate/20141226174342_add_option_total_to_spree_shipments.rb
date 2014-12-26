class AddOptionTotalToSpreeShipments < ActiveRecord::Migration
  def change
    add_column :spree_shipments, :option_total, :integer
  end
end
