class AddEntryColumns < ActiveRecord::Migration[6.0]
  def change
    change_table :fairs do |t|
      t.boolean :in_person, default: true
      t.boolean :scored, default: true
      t.text :materials
      t.string :culture
      t.string :time_period
      t.boolean :pentathlon, default: false
      t.boolean :division, default: false
      t.boolean :first_time, default: false
      t.boolean :youth, default: false
    end
  end
end
