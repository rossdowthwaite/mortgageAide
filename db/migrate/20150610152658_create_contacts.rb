class CreateContacts < ActiveRecord::Migration
  def change
    create_table :contacts do |t|
      t.string :fname
      t.string :mname
      t.string :lname
      t.string :title
      t.date :dob
      t.belongs_to :user, index: true, foreign_key: true
      t.belongs_to :role, index: true, foreign_key: true

      t.timestamps null: false
    end
  end
end
