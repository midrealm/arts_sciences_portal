class EntryPolicy < ApplicationPolicy
  def initialize(user, entry)
    @user = user
    @entry = entry
  end

  def owns_entry?
    @user.admin? || UserEntry.entrants(@entry).include?(@user)
  end

  def entry_open?
    @user.admin? || (!@entry.fair.finalized && @entry.fair.entries_allowed)
  end

  def kingdom_open?
    @user.admin? || (!@entry.fair.finalized && @entry.fair.entries_allowed)
  end
end
