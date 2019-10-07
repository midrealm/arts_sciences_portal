class Timeslot < ApplicationRecord
  has_many :judge_assigns

  scope :in_order, -> { order(order: :asc) }
end
