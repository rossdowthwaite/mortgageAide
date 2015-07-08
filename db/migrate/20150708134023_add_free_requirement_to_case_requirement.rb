class AddFreeRequirementToCaseRequirement < ActiveRecord::Migration
  def change
    add_column :case_requirements, :free_requirement, :text
  end
end
