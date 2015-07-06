class CreateCaseRequirements < ActiveRecord::Migration
  def change
    create_table :case_requirements do |t|
      t.belongs_to :application_case, index: true, foreign_key: true
      t.belongs_to :requirement, index: true, foreign_key: true

      t.timestamps null: false
    end
  end
end
