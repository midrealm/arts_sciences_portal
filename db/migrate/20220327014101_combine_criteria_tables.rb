class CombineCriteriaTables < ActiveRecord::Migration[6.0]
  def change
    rename_column :criteria_types, :description, :name
    add_column :criteria_types, :description, :text
    add_reference :criteria_types, :division, null: false, foreign_key: true, default: 6
    remove_reference :criteria, :division, null: false, foreign_key: true
  end
end
