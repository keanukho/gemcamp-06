# app/controllers/application_controller.rb
class ApplicationController < ActionController::Base
  # Other code...
  before_action :configure_permitted_parameters, if: :devise_controller?

  protected

  def configure_permitted_parameters
    devise_parameter_sanitizer.permit(:sign_up, keys: [:phone_number])
  end
end
