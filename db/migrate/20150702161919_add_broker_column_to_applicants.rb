class AddBrokerColumnToApplicants < ActiveRecord::Migration
  def change
    add_column :applicants, :broker_id, :integer
  end
end
