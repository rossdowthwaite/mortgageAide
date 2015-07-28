class AddLifetimeToAppicationCase < ActiveRecord::Migration
  def change
    add_column :application_cases, :lifetime, :boolean
  end
end
