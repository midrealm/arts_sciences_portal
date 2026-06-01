class JudgePreference < ApplicationRecord
  belongs_to :user
  belongs_to :preference

  scope :for_user, -> (user) { where("user_id = ?", user.id) }
  scope :default_order, -> { joins(:preference).order(:name) }
end
