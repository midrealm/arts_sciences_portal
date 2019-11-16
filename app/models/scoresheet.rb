class Scoresheet < ApplicationRecord
  belongs_to :user
  belongs_to :entry
  has_many :scores
  accepts_nested_attributes_for :scores
end
