class CreateApplicableCriteria < ActiveRecord::Migration[6.0]
  def change
    create_table :applicable_criteria do |t|
      t.references :criteria_type, null: false, foreign_key: true
      t.references :category, null: false, foreign_key: true

      t.timestamps
    end
  end
end
