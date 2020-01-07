class AddNamesToUser < ActiveRecord::Migration[6.0]
  def change
    change_table :users do |t|
      t.string :sca_name, null: true
      t.string :name, null: true
    end
  end
end
