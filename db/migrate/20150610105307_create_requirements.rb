class CreateRequirements < ActiveRecord::Migration
  def change
    create_table :requirements do |t|
      t.string :requirment
      t.date :date_needed

      t.timestamps null: false
    end
  end
end
