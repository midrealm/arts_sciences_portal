class Fair < ApplicationRecord
  belongs_to :region

  has_many :entries
end
