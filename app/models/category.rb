class Category < ApplicationRecord
  has_many :entries
  has_many :judge_preferences
  belongs_to :division
end
