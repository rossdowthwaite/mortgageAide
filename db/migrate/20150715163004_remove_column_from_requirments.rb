class RemoveColumnFromRequirments < ActiveRecord::Migration
  def change
	remove_column :requirements, :date_needed
  end
end
