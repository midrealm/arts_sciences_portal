class CreateDivisions < ActiveRecord::Migration[6.0]
  def change
    create_table :divisions do |t|
      t.string :name

      t.timestamps
    end

    add_reference :categories, :division, null: false, foreign_key: true
  end
end
