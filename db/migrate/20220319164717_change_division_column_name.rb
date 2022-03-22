class ChangeDivisionColumnName < ActiveRecord::Migration[6.0]
  def change
    rename_column :entries, :division, :division_type
  end
end
