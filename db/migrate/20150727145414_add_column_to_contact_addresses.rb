class AddColumnToContactAddresses < ActiveRecord::Migration
  def change
    add_column :contact_addresses, :county, :string
  end
end
