class CreateGlobalSettings < ActiveRecord::Migration
  def change
    create_table :global_settings do |t|
      t.belongs_to :user, index: true, foreign_key: true
      t.string :color_one
      t.string :color_two
      t.string :color_three

      t.timestamps null: false
    end
  end
end
