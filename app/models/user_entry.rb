class UserEntry < ApplicationRecord
  belongs_to :user
  belongs_to :entry

  def self.entrants(entry)
    user_entries = UserEntry.where(entry_id: entry.id).pluck(:user_id)
    User.find(user_entries)
  end
end
