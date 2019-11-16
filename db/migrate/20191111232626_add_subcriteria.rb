class AddSubcriteria < ActiveRecord::Migration[6.0]
  def change
    change_table :criteria_types do |t|
      t.references :criteria_type, :parent, null: true
    end
  end
end
