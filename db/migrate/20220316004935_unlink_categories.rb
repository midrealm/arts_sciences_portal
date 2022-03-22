class UnlinkCategories < ActiveRecord::Migration[6.0]
  def change
    remove_reference :categories, :division, foreign_key: true
    remove_reference :entries, :category, foreign_key: true
    remove_reference :criteria, :category, foreign_key: true
    remove_reference :applicable_criteria, :category, foreign_key: true
    remove_reference :criteria_descriptions, :category, foreign_key: true
    remove_reference :judge_preferences, :category, foreign_key: true

    add_reference :categories, :division, null: false, foreign_key: true
    add_reference :entries, :division, null: false, foreign_key: true
    add_reference :criteria, :division, null: false, foreign_key: true
    add_reference :applicable_criteria, :division, null: false, foreign_key: true
    add_reference :criteria_descriptions, :division, null: false, foreign_key: true
    add_reference :judge_preferences, :division, null: false, foreign_key: true

    add_column :divisions, :description, :text
    drop_table :categories
  end
end
