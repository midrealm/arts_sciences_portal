class JudgeAssign < ApplicationRecord
  belongs_to :user
  belongs_to :entry
  belongs_to :timeslot

  scope :in_schedule_order, -> { joins(:timeslot).order(order: :asc) }
end
