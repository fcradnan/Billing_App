class ApplicationController < ActionController::Base
  include Pundit::Authorization

  rescue_from Pundit::NotAuthorizedError, with: :user_not_authorized

  before_action :configure_permitted_parameters, if: :devise_controller?

  protected

  def after_sign_in_path_for(resource)
    if resource.type == "Admin"
      admin_dashboard_path
    else
      buyer_dashboard_path
    end
  end

  def after_sign_out_path_for(_resource_or_scope)
    new_user_session_path
  end

  def configure_permitted_parameters
    devise_parameter_sanitizer.permit(:sign_up, keys: [:name])
    devise_parameter_sanitizer.permit(:account_update, keys: [:name])
  end

  private

  def user_not_authorized
    flash[:alert] = "You are not authorized to perform this action."
    if current_user.type == "Admin"
      redirect_to admin_dashboard_path
    else
      redirect_to buyer_dashboard_path
    end
  end
end
