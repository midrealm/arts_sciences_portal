class FinalizeFair < ActiveRecord::Migration[6.0]
  def change
    change_table :fairs do |t|
      t.boolean :finalized, default: false
    end
  end
end
