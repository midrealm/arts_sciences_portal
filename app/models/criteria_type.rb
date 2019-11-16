class CriteriaType < ApplicationRecord
  has_many :criteriums
  belongs_to :parent, class_name: 'CriteriaType', optional: true
  has_many :children, class_name: 'CriteriaType', foreign_key: 'parent_id'

  scope :top_level, -> { where('parent_id is null') }
end
