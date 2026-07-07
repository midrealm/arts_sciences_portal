class Preference < ApplicationRecord
  has_many :judge_preferences
  has_many :entry_preferences, dependent: :destroy
  has_many :entries, through: :entry_preferences

  scope :default_order, -> { order(:name) }
end
