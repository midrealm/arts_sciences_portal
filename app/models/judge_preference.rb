class JudgePreference < ApplicationRecord
  belongs_to :user
  belongs_to :category

  scope :for_user, -> (user) {where("user_id = ?", user.id)}
end
