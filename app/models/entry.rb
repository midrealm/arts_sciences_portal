class Entry < ApplicationRecord
  belongs_to :user

  has_many :judge_assigns, class_name: 'JudgeAssign', foreign_key: :entry_id

  scope :user_entries, -> (user) { where('user_id = ?', user.id) }
end
