class Entry < ApplicationRecord
  belongs_to :user
  belongs_to :category
  belongs_to :timeslot
  belongs_to :fair

  has_many :judge_assigns

  scope :user_entries, -> (user) { where('user_id = ?', user.id) }
  scope :in_schedule_order, -> { joins(:timeslot).order(order: :asc) }
end
