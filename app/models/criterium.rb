class Criterium < ApplicationRecord
  belongs_to :criteria_type
  belongs_to :category
  has_many :applicable_criteriums

  scope :by_type, -> (criteria_id) {where("criteria_type_id = ?", criteria_id)}
  scope :by_category, -> (category_id) {where("category_id = ?", category_id)}
  scope :sub_criteria, -> {where.not(name: '')}
end
