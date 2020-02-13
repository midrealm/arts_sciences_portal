class MailInToggling < ActiveRecord::Migration[6.0]
  def change
    change_table :fairs do |t|
      t.boolean :scoresheets_allowed, default: false
      t.boolean :mail_in_scoresheets_allowed, default: false
    end
  end
end
