class AddFreeRequirementColumnToRequirements < ActiveRecord::Migration
  def change
    add_column :requirements, :free_requirement, :string
  end
end
