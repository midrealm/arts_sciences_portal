class CreateRegions < ActiveRecord::Migration[6.0]
  def change
    create_table :regions do |t|
      t.string :name

      t.timestamps
    end

    add_reference :users, :region, null: false, foreign_key: true
    add_reference :fairs, :region, null: false, foreign_key: true
  end
end
