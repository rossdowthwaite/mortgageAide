class CreateApplicants < ActiveRecord::Migration
  def change
    create_table :applicants do |t|
      t.belongs_to :application_case, index: true, foreign_key: true
      t.belongs_to :contact, index: true, foreign_key: true

      t.timestamps null: false
    end
  end
end
