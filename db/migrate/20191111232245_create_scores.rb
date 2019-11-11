class CreateScores < ActiveRecord::Migration[6.0]
  def change
    create_table :scores do |t|
      t.references :criteria, null: false, foreign_key: true
      t.text :comment
      t.integer :score

      t.timestamps
    end
  end
end
