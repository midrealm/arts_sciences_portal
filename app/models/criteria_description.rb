class CriteriaDescription < ApplicationRecord
  belongs_to :division
  belongs_to :criteria_type

  scope :by_type, -> (criteria_id) { where("criteria_type_id = ?", criteria_id)}
  scope :by_division, -> (division_id) { where("division_id = ?", division_id)}

  def self.description_for_division(criteria_id, division_id)
    record = CriteriaDescription.all.by_type(criteria_id).by_division(division_id)
    record.empty? ? "" : record.first.description
  end
end
