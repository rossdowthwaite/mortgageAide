class AddColumnToRequirements < ActiveRecord::Migration
  def change
    add_column :case_requirements, :date_satisfied, :datetime
  end
end
