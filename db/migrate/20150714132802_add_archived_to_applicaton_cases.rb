class AddArchivedToApplicatonCases < ActiveRecord::Migration
  def change
    add_column :application_cases, :archived, :boolean
  end
end
