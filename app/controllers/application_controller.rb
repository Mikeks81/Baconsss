class ApplicationController < ActionController::Base

  protect_from_forgery with: :exception
  before_action :authenticate_user!
  before_action :configure_permitted_parameters, if: :devise_controller?


  def after_sign_in_path_for(resource)
  	user_path(resource)
  end

  protected

  def configure_permitted_parameters
    devise_parameter_sanitizer.permit(:sign_up) do |user_params|
    	user_params.permit(:email, :password, :password_confirmation, :phones_attributes => [:id, :phone_type, :phone_number])
    end
    devise_parameter_sanitizer.permit(:account_update) do |user_params|
    	user_params.permit(:email, :password, :password_confirmation, :phones_attributes => [:id, :phone_type, :phone_number])
    end
  end
end
