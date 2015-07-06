class CreateApplicationCases < ActiveRecord::Migration
  def change
    create_table :application_cases do |t|
      t.string :valuation
      t.string :product
      t.datetime :expiry
      t.integer :mortgage
      t.string :term
      t.string :repayment
      t.string :status

      t.timestamps null: false
    end
  end
end
