class AddFairColumns < ActiveRecord::Migration[6.0]
  def change
    change_table :fairs do |t|
      t.string :name
      t.boolean :internet_access
      t.text :comment
    end
  end
end
