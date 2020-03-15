include FairsHelper

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

  def promotable?
    kingdom_fair = next_kingdom_fair
    # check that it hasn't already been promoted
    promoted_already = (@entry.fair_id == next_kingdom_fair.id || !Entry.find_by(prior_entry_id: @entry.id).nil?)
    @user.admin? || (!promoted_already && kingdom_fair.entries_allowed) && @entry.final_score > 0)
  end
end
