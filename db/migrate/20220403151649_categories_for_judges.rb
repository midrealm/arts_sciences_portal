class CategoriesForJudges < ActiveRecord::Migration[6.0]
  def change
    create_table :categories do |t|
      t.string :name

      t.timestamps
    end

    remove_reference :judge_preferences, :division
    add_reference :judge_preferences, :category, null: false, foreign_key: true
  end
end
