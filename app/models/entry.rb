class Entry < ApplicationRecord
  belongs_to :category
  belongs_to :timeslot, optional: true
  belongs_to :fair
  belongs_to :location, optional: true

  has_many :user_entries, dependent: :destroy
  has_many :judge_assigns, dependent: :destroy
  has_many :scoresheets, dependent: :destroy

  validates_presence_of :entry_name

  scope :user_entries, -> (user) { joins(:user_entries).where('user_entries.user_id = ?', user.id) }
  scope :judge_assigned_entries, -> (user) { joins(:judge_assigns).where('judge_assigns.user_id = ?', user.id) }
  scope :fair_entries, -> (fair) { where('fair_id = ?', fair.id) }
  scope :in_schedule_order, -> { joins(:timeslot).order(order: :asc) }

  def timeslot_description
    self.timeslot.nil? ? "Unassigned" : self.timeslot.description
  end

  def location_description
    self.location.nil? ? "Unassigned" : self.location.description
  end

  def in_person_option
    self.in_person ? "Face-to-face" : "Not face-to-face"
  end

  def scored_option
    self.scored ? "Scored" : "Commentary Only"
  end

  def judge_name_or_unnassigned
    if self.judge_assigns.empty?
      'Unassigned'
    else
      judges = self.judge_assigns.map do |judge|
        judge.user.email_or_name
      end
      judges.join("<br>")
    end
  end
end
