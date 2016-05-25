class AddEmailToSpreeAddress < ActiveRecord::Migration
  def change
    add_column :spree_addresses, :email, :string
    add_column :spree_addresses, :email_confirm, :string
  end
end
