class Category < ApplicationRecord
  has_many :entries
  has_many :judge_preferences
  has_many :criteriums
  has_many :applicable_criteriums
  belongs_to :division
end
