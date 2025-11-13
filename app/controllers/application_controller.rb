class ApplicationController < ActionController::Base
  # Ensure Devise permits extra fields
  before_action :configure_permitted_parameters, if: :devise_controller?

  # Redirect after login
  def after_sign_in_path_for(resource)
    events_path
  end

  # Redirect after logout
  def after_sign_out_path_for(resource_or_scope)
    new_user_session_path
  end

  protected

  # Permit name + role for Devise (signup & account edit)
  def configure_permitted_parameters
    devise_parameter_sanitizer.permit(:sign_up, keys: [:name, :role])
    devise_parameter_sanitizer.permit(:account_update, keys: [:name, :role])
  end
end
