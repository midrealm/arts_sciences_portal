class CreateJudgeFairs < ActiveRecord::Migration[6.0]
  def change
    create_table :judge_fairs do |t|
      t.references :user, null: false, foreign_key: true
      t.references :fair, null: false, foreign_key: true

      t.timestamps
    end
  end
end
