class CreateExtraDetails < ActiveRecord::Migration
  def change
    create_table :extra_details do |t|
      t.string :branch
      t.belongs_to :user, index: true, foreign_key: true

      t.timestamps null: false
    end
  end
end
