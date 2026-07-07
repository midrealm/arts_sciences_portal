class AddDeprecatedToDivisionsAndCriteria < ActiveRecord::Migration[8.0]
  def change
    add_column :divisions, :deprecated, :boolean, null: false, default: false
    add_column :criteria, :deprecated, :boolean, null: false, default: false
  end
end
