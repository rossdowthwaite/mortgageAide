class RemovelendersColumnFromCaseRequirements < ActiveRecord::Migration
  def change
  	remove_column :application_cases, :lenders
  	add_column :application_cases, :lender_id, :integer
  end
end
