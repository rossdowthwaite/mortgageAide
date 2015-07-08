class AddAddressIdColumnToApplicationCases < ActiveRecord::Migration
  def change
    add_column :application_cases, :mortgage_address_id, :integer
  end
end
