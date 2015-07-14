class ChangePhoneNumbersColumnAgain < ActiveRecord::Migration
  def change
  	change_column :phone_numbers, :phone_number, :string
  end
end
