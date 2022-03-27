class Division < ApplicationRecord
  has_many :entries
  has_many :judge_preferences
  has_many :criteria_types
  has_many :applicable_criteriums

  scope :default_order, -> {order(:name)}
end
