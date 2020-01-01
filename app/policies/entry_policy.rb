class EntryPolicy < ApplicationPolicy
  def initialize(user, entry)
    @user = user
    @entry = entry
  end

  def owns_entry?
    @user.admin? || UserEntry.entrants(@entry).include?(@user)
  end
end
