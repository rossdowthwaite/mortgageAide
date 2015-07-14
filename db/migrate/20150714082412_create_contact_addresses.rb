class CreateContactAddresses < ActiveRecord::Migration
  def change
    create_table :contact_addresses do |t|
      t.string :address_one
      t.string :address_two
      t.string :town
      t.string :post_code
      t.boolean :primary
      t.belongs_to :user, index: true, foreign_key: true

      t.timestamps null: false
    end
  end
end
