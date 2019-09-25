class CreateFairs < ActiveRecord::Migration[6.0]
  def change
    create_table :fairs do |t|
      t.date :date

      t.timestamps
    end
  end
end
