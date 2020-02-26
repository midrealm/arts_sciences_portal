class JudgeFair < ApplicationRecord
  belongs_to :user
  belongs_to :fair

  scope :for_user, -> (user) { where(user_id: user.id).joins(:fair).where('finalized = ?', false) }
end
