class ChangeApplicationCaseColumn < ActiveRecord::Migration
  def change
    change_column :application_cases, :active, :string
  end
end
