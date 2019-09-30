class CreateCategories < ActiveRecord::Migration[6.0]
  def change
    create_table :categories do |t|
      t.string :name

      t.timestamps
    end

    add_reference :entries, :category, null: false, foreign_key: true
  end
end
