class AddAndRemoveMortgageFieldFromApplicationCase < ActiveRecord::Migration
  def change
    change_column :application_cases, :mortgage, :integer
    change_column :application_cases, :valuation, :integer
  end
end
