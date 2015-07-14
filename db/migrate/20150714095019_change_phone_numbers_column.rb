class ChangePhoneNumbersColumn < ActiveRecord::Migration
  def change
  	change_column :phone_numbers, :phone_number, :bigint
  end
end
