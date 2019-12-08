class Entry < ApplicationRecord
  belongs_to :user
  belongs_to :category
  belongs_to :timeslot, optional: true
  belongs_to :fair

  has_many :judge_assigns
  has_many :scoresheets

  scope :user_entries, -> (user) { where('user_id = ?', user.id) }
  scope :judge_assigned_entries, -> (user) { joins(:judge_assigns).where('judge_assigns.user_id = ?', user.id) }
  scope :fair_entries, -> (fair) { where('fair_id = ?', fair.id) }
  scope :in_schedule_order, -> { joins(:timeslot).order(order: :asc) }

  def timeslot_description
    self.timeslot.nil? ? "Unassigned" : self.timeslot.description
  end

  def in_person_option
    self.in_person ? "Face-to-face" : "Not face-to-face"
  end

  def scored_option
    self.scored ? "Scored" : "Commentary Only"
  end
end
