class CreateEntryPreferences < ActiveRecord::Migration[6.0]
  def change
    create_table :entry_preferences do |t|
      t.references :entry, null: false, foreign_key: true
      t.references :preference, null: false, foreign_key: true

      t.timestamps
    end

    add_index :entry_preferences, [:entry_id, :preference_id], unique: true
  end
end

