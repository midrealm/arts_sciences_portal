class CreateJudgePreferences < ActiveRecord::Migration[6.0]
  def change
    create_table :judge_preferences do |t|

      t.timestamps
    end

    add_reference :judge_preferences, :user, null: false, foreign_key: true
    add_reference :judge_preferences, :category, null: false, foreign_key: true
  end
end
