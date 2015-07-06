class RenameCol < ActiveRecord::Migration
  def change
  	rename_column :application_cases, :type, :app_type
  end
end
