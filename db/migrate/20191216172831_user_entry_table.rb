class UserEntryTable < ActiveRecord::Migration[6.0]
  def change
    create_table :user_entries do |t|

      t.timestamps
    end

    add_reference :user_entries, :user, null: false, foreign_key: true
    add_reference :user_entries, :entry, null: false, foreign_key: true
  end

  remove_column :entries, :user_id
end
