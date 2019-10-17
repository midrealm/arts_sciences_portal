class JudgePreferencePolicy < ApplicationPolicy
  def initialize(user, user_id)
    @user = user
    @user_id = user_id
  end

  def owns_preference?
    @user.id.to_s == @user_id || @user.admin?
  end
end
