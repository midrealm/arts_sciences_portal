class Peerage < ApplicationRecord
  has_many :user_peerages
  has_many :users, through: :user_peerages
end
