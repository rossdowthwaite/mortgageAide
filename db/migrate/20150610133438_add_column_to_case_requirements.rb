class AddColumnToCaseRequirements < ActiveRecord::Migration
  def change
  	add_column :case_requirements, :date_requested, :date
  	add_column :case_requirements, :status, :string
  end
end
