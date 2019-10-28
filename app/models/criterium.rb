class Criterium < ApplicationRecord
  belongs_to :criteria_type
  belongs_to :category

  scope :by_type, -> (criteria_id) { where("criteria_type_id = ?", criteria_id)}
  scope :by_category, -> (category_id) { where("category_id = ?", category_id)}
end
