class CreateScoresheets < ActiveRecord::Migration[6.0]
  def change
    create_table :scoresheets do |t|
      t.references :score, null: false, foreign_key: true
      t.references :user, null: false, foreign_key: true
      t.references :entry, null: false, foreign_key: true

      t.timestamps
    end
  end
end
