class Region < ApplicationRecord
  has_many :users
  has_many :fairs
end
