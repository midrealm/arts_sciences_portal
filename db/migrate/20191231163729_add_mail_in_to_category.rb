class AddMailInToCategory < ActiveRecord::Migration[6.0]
  def change
    change_table :categories do |t|
      t.boolean :mail_in, default: false
    end
  end
end
