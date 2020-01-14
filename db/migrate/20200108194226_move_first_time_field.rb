class MoveFirstTimeField < ActiveRecord::Migration[6.0]
  def change
    remove_column :users, :first_time

    change_table :judge_fairs do |t|
      t.boolean :first_time, default: false
    end
  end
end
