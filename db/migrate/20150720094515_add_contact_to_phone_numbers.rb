class AddContactToPhoneNumbers < ActiveRecord::Migration
  def change
    add_reference :phone_numbers, :contact, index: true, foreign_key: true
  end
end
