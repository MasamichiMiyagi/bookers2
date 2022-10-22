class ApplicationController < ActionController::Base

  before_action :authenticate_user!, except: [:top, :about]
  before_action :configure_permitted_parameters, if: :devise_controller?

  def after_sign_in_path_for(resource)
    if @user
      redirect_to user_path(resource), notice: 'Signed in successfully.'
    else
      render user_session_path
    end
  end

  def after_sign_out_path_for(resource)
    redirect_to root_path, notice: 'Signed out successfully.'
  end

  protected

  def configure_permitted_parameters
    devise_parameter_sanitizer.permit(:sign_up, keys: [:name])
  end
end
