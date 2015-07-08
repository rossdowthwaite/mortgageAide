class RemoveValuationFromApplicationCases < ActiveRecord::Migration
  def change
  	remove_column :application_cases, :valuation
  	add_column :application_cases, :valuation, :decimal, :precision => 10, :scale => 2
  end
end
