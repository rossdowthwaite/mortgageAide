class CreateMortgageAddresses < ActiveRecord::Migration
  def change
    create_table :mortgage_addresses do |t|
      t.string :address_one
      t.string :address_two
      t.string :town
      t.string :county
      t.string :pcode
      t.belongs_to :application_case, index: true, foreign_key: true

      t.timestamps null: false
    end
  end
end
