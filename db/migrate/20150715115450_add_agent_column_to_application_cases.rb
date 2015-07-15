class AddAgentColumnToApplicationCases < ActiveRecord::Migration
  def change
    add_column :application_cases, :agent_id, :integer
  end
end
