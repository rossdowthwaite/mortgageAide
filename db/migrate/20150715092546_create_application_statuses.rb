class CreateApplicationStatuses < ActiveRecord::Migration
  def change
    create_table :application_statuses do |t|
      t.belongs_to :application_case, index: true, foreign_key: true
      t.belongs_to :status, index: true, foreign_key: true

      t.timestamps null: false
    end
  end
end
