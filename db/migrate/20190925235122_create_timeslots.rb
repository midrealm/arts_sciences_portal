class CreateTimeslots < ActiveRecord::Migration[6.0]
  def change
    create_table :timeslots do |t|
      t.integer :order
      t.string :description

      t.timestamps
    end

    add_reference :entries, :timeslot, null: true, foreign_key: true
  end
end
