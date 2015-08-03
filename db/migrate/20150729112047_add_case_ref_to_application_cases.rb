class AddCaseRefToApplicationCases < ActiveRecord::Migration
  def change
    add_column :application_cases, :case_ref, :string
  end
end
