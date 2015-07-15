class RemoveRoleIdfromContacts < ActiveRecord::Migration
  def change
  	remove_column :contacts, :role_id
  end
end
