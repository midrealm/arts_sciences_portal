class JudgePreference < ApplicationRecord
  belongs_to :user
  belongs_to :division

  scope :for_user, -> (user) {where("user_id = ?", user.id)}
  scope :default_order, -> {joins(:division).order(:name)}
end
