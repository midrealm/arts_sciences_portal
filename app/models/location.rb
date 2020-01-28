class Location < ApplicationRecord
  belongs_to :fair

  has_many :entries

  scope :for_fair, -> (fair) { where('fair_id = ?', fair.id) }
end
