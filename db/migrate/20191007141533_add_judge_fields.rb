class AddJudgeFields < ActiveRecord::Migration[6.0]
  def change
    change_table :users do |t|
      t.boolean :written, default: false
      t.boolean :first_time, default: false
    end
  end
end
