class CreateLocations < ActiveRecord::Migration[6.0]
  def change
    create_table :locations do |t|
      t.string :description
      t.references :fair, null: false, foreign_key: true

      t.timestamps
    end

    change_table :entries do |t|
      t.references :location, null: true, foreign_key: true
    end
  end
end
