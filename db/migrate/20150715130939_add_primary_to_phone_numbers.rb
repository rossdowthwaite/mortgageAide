class AddPrimaryToPhoneNumbers < ActiveRecord::Migration
  def change
    add_column :phone_numbers, :primary, :boolean
  end
end
