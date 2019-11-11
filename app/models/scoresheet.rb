class Scoresheet < ApplicationRecord
  belongs_to :score
  belongs_to :user
  belongs_to :entry
end
