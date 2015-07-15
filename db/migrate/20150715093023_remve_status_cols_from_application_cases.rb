class RemveStatusColsFromApplicationCases < ActiveRecord::Migration
  def change
  	remove_column :application_cases, :status_id
  end
end
