class PromoteEntry < ActiveRecord::Migration[6.0]
  def change
    change_table :entries do |t|
      t.references :prior_entry, references: :entry
    end
  end
end
