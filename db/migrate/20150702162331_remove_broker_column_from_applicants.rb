class RemoveBrokerColumnFromApplicants < ActiveRecord::Migration
  def change
  	remove_column :applicants, :broker_id
  	add_column :applicants, :is_broker, :boolean
  end
end
