class AddCascadeOnContactUserDeleteAgain < ActiveRecord::Migration
  def change
  	remove_foreign_key :contacts, :users
  	add_foreign_key :contacts, :users, dependent: :cascade
  end
end
