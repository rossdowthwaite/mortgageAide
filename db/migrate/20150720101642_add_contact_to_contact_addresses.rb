class AddContactToContactAddresses < ActiveRecord::Migration
  def change
    add_reference :contact_addresses, :contact, index: true, foreign_key: true
  end
end
