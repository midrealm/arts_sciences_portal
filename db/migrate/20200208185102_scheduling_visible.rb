class SchedulingVisible < ActiveRecord::Migration[6.0]
  def change
    change_table :fairs do |t|
      t.boolean :scheduling_visible, default: false
    end
  end
end
