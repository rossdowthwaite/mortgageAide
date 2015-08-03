class CreateClientAgents < ActiveRecord::Migration
  def change
    create_table :client_agents do |t|
      t.integer :client_id
      t.integer :agent_id

      t.timestamps null: false
    end
  end
end
