class Score < ApplicationRecord
  belongs_to :criteria_type
  belongs_to :scoresheet
end
