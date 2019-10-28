class AddEntryToFair < ActiveRecord::Migration[6.0]
  def change
    add_reference :entries, :fair, null: false, foreign_key: true
  end
end
