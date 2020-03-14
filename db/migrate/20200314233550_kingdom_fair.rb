class KingdomFair < ActiveRecord::Migration[6.0]
  def change
    change_table :fairs do |t|
      t.boolean :kingdom, default: false
    end
  end
end
