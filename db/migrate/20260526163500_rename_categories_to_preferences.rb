class RenameCategoriesToPreferences < ActiveRecord::Migration[6.0]
  def up
    if table_exists?(:categories) && !table_exists?(:preferences)
      rename_table :categories, :preferences
    elsif !table_exists?(:preferences)
      create_table :preferences do |t|
        t.string :name

        t.timestamps
      end
    end

    if column_exists?(:judge_preferences, :category_id)
      rename_column :judge_preferences, :category_id, :preference_id
    end

    if index_name_exists?(:judge_preferences, "index_judge_preferences_on_category_id")
      rename_index :judge_preferences,
                   "index_judge_preferences_on_category_id",
                   "index_judge_preferences_on_preference_id"
    end
  end

  def down
    if index_name_exists?(:judge_preferences, "index_judge_preferences_on_preference_id")
      rename_index :judge_preferences,
                   "index_judge_preferences_on_preference_id",
                   "index_judge_preferences_on_category_id"
    end

    if column_exists?(:judge_preferences, :preference_id)
      rename_column :judge_preferences, :preference_id, :category_id
    end

    if table_exists?(:preferences) && !table_exists?(:categories)
      rename_table :preferences, :categories
    end
  end
end

