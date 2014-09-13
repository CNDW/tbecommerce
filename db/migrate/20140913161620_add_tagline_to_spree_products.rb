class AddTaglineToSpreeProducts < ActiveRecord::Migration
  def change
    add_column :spree_products, :tagline, :text
  end
end
