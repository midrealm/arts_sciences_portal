class CreateCriteriaTypes < ActiveRecord::Migration[6.0]
  def change
    create_table :criteria_types do |t|
      t.string :description
      t.integer :max_score

      t.timestamps
    end
  end
end
