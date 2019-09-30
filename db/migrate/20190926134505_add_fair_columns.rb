class AddFairColumns < ActiveRecord::Migration[6.0]
  def change
    change_table :fairs do |t|
      t.string :name
      t.boolean :internet_access, default: true
      t.text :comment
    end
  end
end
