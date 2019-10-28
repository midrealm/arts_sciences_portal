class Timeslot < ApplicationRecord
  has_many :entries

  scope :in_order, -> { order(order: :asc) }
end
