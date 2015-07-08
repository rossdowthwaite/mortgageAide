class RemoveFreeRequirementColumnFromRequirements < ActiveRecord::Migration
  def change
  	remove_column :requirements, :free_requirement
  end
end
