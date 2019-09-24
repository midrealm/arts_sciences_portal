class EntryPolicy < ApplicationPolicy
  def initialize(user, entry)
    @user = user
    @entry = entry
  end

  def owns_entry?
    @user == @entry.user || @user.admin?
  end
end
