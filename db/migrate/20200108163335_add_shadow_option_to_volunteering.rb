class AddShadowOptionToVolunteering < ActiveRecord::Migration[6.0]
  def change
    change_table :judge_fairs do |t|
      t.boolean :shadow_judge, default: false
    end
  end
end
