class AddActiveColumnToApplicationCases < ActiveRecord::Migration
  def change
    add_column :application_cases, :active, :boolean
    add_column :application_cases, :reason, :text
  end
end
