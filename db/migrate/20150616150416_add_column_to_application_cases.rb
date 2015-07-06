class AddColumnToApplicationCases < ActiveRecord::Migration
  def change
    add_column :application_cases, :user_id, :integer
  end
end
