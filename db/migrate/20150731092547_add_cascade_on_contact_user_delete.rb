class AddCascadeOnContactUserDelete < ActiveRecord::Migration
  def change
  	remove_foreign_key :contacts, :users
  	add_foreign_key :contacts, :users, dependent: :delete
  end
end
