class RemoveAgentColumnFromApplicationCases < ActiveRecord::Migration
  def change
  	remove_column :application_cases, :agent_id
  end
end
