class Criterium < ApplicationRecord
  belongs_to :criteria_type
  belongs_to :division
  has_many :applicable_criteriums

  scope :by_type, -> (criteria_id) {where("criteria_type_id = ?", criteria_id)}
  scope :by_division, -> (division_id) {where("division_id = ?", division_id)}
end
