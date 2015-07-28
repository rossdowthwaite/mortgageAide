class AddColumsToLender < ActiveRecord::Migration
  def change
    add_column :lenders, :admin_phone, :string
    add_column :lenders, :sales_phone, :string
    add_column :lenders, :hq_address, :text
    add_column :lenders, :email, :string
  end
end
