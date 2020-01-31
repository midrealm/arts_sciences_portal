class ChangeScoreColumnType < ActiveRecord::Migration[6.0]
  def change
    change_column :scores, :score, :decimal
  end
end
