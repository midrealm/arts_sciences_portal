class CreateEntryPreferences < ActiveRecord::Migration[6.0]
  def up
    return if table_exists?(:entry_preferences)

    create_table :entry_preferences do |t|
      t.references :entry, null: false, foreign_key: true
      t.references :preference, null: false, foreign_key: true

      t.timestamps
    end

    add_index :entry_preferences, [:entry_id, :preference_id], unique: true
  end

  def down
    drop_table :entry_preferences if table_exists?(:entry_preferences)
  end
end

