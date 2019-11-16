class CreateScoresheets < ActiveRecord::Migration[6.0]
  def change
    create_table :scoresheets do |t|
      t.references :user, null: false, foreign_key: true
      t.references :entry, null: false, foreign_key: true

      t.timestamps
    end

    change_table :scores do |t|
      t.references :scoresheet, null: false, foreign_key: true
    end
  end
end
