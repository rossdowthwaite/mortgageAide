class AddStatusIdToApplicationCases < ActiveRecord::Migration
  def change
  	remove_column :application_cases, :status
    add_reference :application_cases, :status, index: true, foreign_key: true
  end
end
