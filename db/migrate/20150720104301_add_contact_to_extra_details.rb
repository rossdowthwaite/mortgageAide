class AddContactToExtraDetails < ActiveRecord::Migration
  def change
    add_reference :extra_details, :contact, index: true, foreign_key: true
  end
end
