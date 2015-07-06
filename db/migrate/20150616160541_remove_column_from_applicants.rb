class RemoveColumnFromApplicants < ActiveRecord::Migration
  def change
    remove_column :applicants, :contact_id
  end
end
