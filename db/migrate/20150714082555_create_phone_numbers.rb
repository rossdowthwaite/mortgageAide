class CreatePhoneNumbers < ActiveRecord::Migration
  def change
    create_table :phone_numbers do |t|
      t.integer :phone_number
      t.string :phone_type
      t.belongs_to :user, index: true, foreign_key: true

      t.timestamps null: false
    end
  end
end
