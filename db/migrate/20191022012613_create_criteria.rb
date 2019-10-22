class CreateCriteria < ActiveRecord::Migration[6.0]
  def change
    create_table :criteria do |t|
      t.text :description
      t.belongs_to :criteria_type, null: false, foreign_key: true
      t.belongs_to :category, null: false, foreign_key: true
      t.integer :suggested_score
      t.boolean :optional
      t.boolean :animal

      t.timestamps
    end
  end
end
