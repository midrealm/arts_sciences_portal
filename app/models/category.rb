class Category < ApplicationRecord
  has_many :entries
  belongs_to :division
end
