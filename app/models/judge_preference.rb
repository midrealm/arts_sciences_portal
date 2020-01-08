class JudgePreference < ApplicationRecord
  belongs_to :user
  belongs_to :category

  scope :for_user, -> (user) {where("user_id = ?", user.id)}
  scope :default_order, -> {joins(:category).order("categories.division_id", :name)}
end
