class ApplicationController < ActionController::Base
  include Pundit

  def verify_admin
    authorize :admin, :access?
  end
end
