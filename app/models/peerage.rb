class Peerage < ApplicationRecord
  has_many :users, through: :user_peerage
end
