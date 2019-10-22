class ApplicationController < ActionController::Base
  include Pundit
  before_action :configure_permitted_parameters, if: :devise_controller?, only: [:create]

  rescue_from Pundit::NotAuthorizedError, with: :user_not_authorized

  def verify_admin
    authorize :admin, :access?
  end

  def user_not_authorized
    flash[:alert] = "You are not authorized to perform this action."
    redirect_to(request.referrer || root_path)
  end

  protected

  def configure_permitted_parameters
    devise_parameter_sanitizer.permit(:sign_up, keys: [:region_id])
  end
end
