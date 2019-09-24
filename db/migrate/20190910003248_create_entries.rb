class CreateEntries < ActiveRecord::Migration[6.0]
  def change
    create_table :entries do |t|
      t.string :entry_name
      t.string :description

      t.timestamps
    end

    add_reference :entries, :user, null: false, foreign_key: true
  end
end
