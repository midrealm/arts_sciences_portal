class CreateJudgeAssigns < ActiveRecord::Migration[6.0]
  def change
    create_table :judge_assigns do |t|
      t.boolean :assigned
      t.boolean :shadow

      t.timestamps
    end

    add_reference :judge_assigns, :user, null: false, foreign_key: true
    add_reference :judge_assigns, :entry, null: false, foreign_key: true
  end
end
