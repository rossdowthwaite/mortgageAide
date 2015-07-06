class AddColsApplicationCase < ActiveRecord::Migration
  def change
  	add_column :application_cases, :lenders, :string
  	add_column :application_cases, :type, :string
  end
end
