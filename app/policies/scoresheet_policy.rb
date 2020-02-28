class ScoresheetPolicy < ApplicationPolicy
  def initialize(user, scoresheet)
    @user = user
    @entry = scoresheet.entry
    @scoresheet = scoresheet
  end

  def owns_entry?
    @user.admin? || UserEntry.entrants(@entry).include?(@user)
  end

  def owns_scoresheet?
    @user.admin? || (@scoresheet.user == @user && @entry.fair.finalized)
  end
end
