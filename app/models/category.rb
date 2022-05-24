class Category < ApplicationRecord
  has_many :judge_preferences

  scope :default_order, -> {order(:name)}
end
