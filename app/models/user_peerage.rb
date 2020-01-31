class UserPeerage < ApplicationRecord
  belongs_to :user
  belongs_to :peerage
end
