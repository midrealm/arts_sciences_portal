class RenameCategoriesToPreferences < ActiveRecord::Migration[6.0]
  def change
    rename_table :categories, :preferences
    rename_column :judge_preferences, :category_id, :preference_id
    rename_index :judge_preferences,
                 :index_judge_preferences_on_category_id,
                 :index_judge_preferences_on_preference_id
  end
end

