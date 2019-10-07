class UserPolicy < ApplicationPolicy
  def initialize(user, requested_user)
    @user = user
    @request_user = requested_user
  end

  def correct_user?
    @user == @request_user || @user.admin?
  end
end
