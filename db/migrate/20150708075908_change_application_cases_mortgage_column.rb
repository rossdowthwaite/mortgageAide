class ChangeApplicationCasesMortgageColumn < ActiveRecord::Migration
  def change
  	change_column :application_cases, :mortgage, :decimal, :precision => 10, :scale => 2
  end
end
