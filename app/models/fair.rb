class Fair < ApplicationRecord
  belongs_to :region

  has_many :entries
  has_many :judge_fairs
end
