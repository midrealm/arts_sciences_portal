class Scoresheet < ApplicationRecord
  belongs_to :user
  belongs_to :entry
  has_many :scores, dependent: :destroy
  
  accepts_nested_attributes_for :scores

  scope :for_user, -> (user) { where("user_id = ?", user.id)}
  scope :for_fair, -> (fair) { joins(:entry).where(entries: {fair_id: fair.id})}

  def shadow_scoresheet?
    JudgeAssign.find_by(entry_id: entry_id, user_id: user_id).shadow
  end

  def total_score
    all_relevant_scores = self.scores.pluck(:score)
    all_relevant_scores.reduce(:+)
  end
end
