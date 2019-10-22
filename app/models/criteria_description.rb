class CriteriaDescription < ApplicationRecord
  belongs_to :category
  belongs_to :criteria_type

  scope :by_type, -> (criteria_id) { where("criteria_type_id = ?", criteria_id)}
  scope :by_category, -> (category_id) { where("category_id = ?", category_id)}

  def self.description_for_category(criteria_id, category_id)
    record = CriteriaDescription.all.by_type(criteria_id).by_category(category_id)
    record.empty? ? "" : record.first.description
  end
end
