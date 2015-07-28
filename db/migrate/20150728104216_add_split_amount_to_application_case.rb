class AddSplitAmountToApplicationCase < ActiveRecord::Migration
  def change
    add_column :application_cases, :split_amount, :string
  end
end
