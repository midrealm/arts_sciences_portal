class AddDeprecateFieldForCriteria < ActiveRecord::Migration[8.0]
  def change
    add_column :criteria_types, :deprecated, :boolean, null: false, default: false
  end
end
