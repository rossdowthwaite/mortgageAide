class CreateNotes < ActiveRecord::Migration
  def change
    create_table :notes do |t|
      t.text :note
      t.belongs_to :application_case, index: true, foreign_key: true

      t.timestamps null: false
    end
  end
end
