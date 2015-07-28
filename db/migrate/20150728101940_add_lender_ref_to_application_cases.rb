class AddLenderRefToApplicationCases < ActiveRecord::Migration
  def change
    add_column :application_cases, :lender_ref, :string
  end
end
