class Entry < ApplicationRecord
  belongs_to :user
  belongs_to :category

  has_many :judge_assigns

  scope :user_entries, -> (user) { where('user_id = ?', user.id) }
end
