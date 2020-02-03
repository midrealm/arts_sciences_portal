class ToggleEntriesForFair < ActiveRecord::Migration[6.0]
  def change
    change_table :fairs do |t|
      t.boolean :entries_allowed, default: false
    end
  end
end
