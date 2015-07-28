class AddAsRoleColumnToApplicants < ActiveRecord::Migration
  def change
    add_column :applicants, :as_role, :string
  end
end
